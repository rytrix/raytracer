#include "raytracer_app.hpp"
#include "camera.hpp"
#include "vulkan/vulkan_core.h"
#include <fstream>

namespace raytracer { 

static void mouse_callback(GLFWwindow* window, double xpos, double ypos) {
    static float lastX = 0.f, lastY = 0.f;
    static bool firstMouse = true;

    //if (firstMouse) {
    //    lastX = xpos;
    //    lastY = ypos;
    //    firstMouse = false;
    //}

    float xoffset = xpos - lastX;
    float yoffset = lastY - ypos; // reversed since y-coordinates go from bottom to top

    lastX = xpos;
    lastY = ypos;

    svklib::window* win = static_cast<svklib::window*>(glfwGetWindowUserPointer(window));
    gllib::camera* camera = static_cast<gllib::camera*>(win->getWindowUserPointer());
    camera->rotate(xoffset, yoffset, 0.01f);
}

static bool captured = false;

static constexpr int scaling = 4;

application::application()
:   window("Raytracing",1000,800),
    instance(window,VK_API_VERSION_1_3),
    swapchain(instance,3,VK_IMAGE_USAGE_TRANSFER_DST_BIT),
    compute_pipeline(instance),
    sync(instance,3),
    descriptor_allocator(instance.getDescriptorPool()),
    camera(60, 0.1, 1000, 1000, 800, glm::vec3{0.f}),
    threadpool(svklib::threadpool::get_instance())
{
//    uniform_buffer = instance.createUniformBuffer(sizeof(ubo));
    compute_images.resize(swapchain.framesInFlight); 
    for (int i = 0; i < swapchain.framesInFlight; i++) {
        compute_images[i] = instance.createComputeImage(VK_IMAGE_TYPE_2D, {swapchain.swapChainExtent.width,swapchain.swapChainExtent.height,1});
        instance.createImageView(compute_images[i], VK_FORMAT_R8G8B8A8_UNORM, VK_IMAGE_VIEW_TYPE_2D, VK_IMAGE_ASPECT_COLOR_BIT);
    }
    swapchainPipelineBarrier();

    createPipeline();
    window.setWindowUserPointer(&camera);
}

application::~application() {
    for (auto& image : compute_images) {
        instance.destroyImage(image);
    }
//    instance.destroyBuffer(uniform_buffer);
}

void application::createPipeline() {
    auto compute_builder = svklib::compute::pipeline::builder::begin(instance);
    compute_builder.buildShader("res/shader.comp.glsl", VK_SHADER_STAGE_COMPUTE_BIT)
        .addDescriptorSetLayout(createDescriptorSets())
        .buildPushConstant(VK_SHADER_STAGE_COMPUTE_BIT, 0, 128)
        .buildPipelineLayout();

    compute_builder.buildPipeline(nullptr,&compute_pipeline);
}

VkDescriptorSetLayout application::createDescriptorSets() {
    svklib::descriptor::builder descriptorBuilder = instance.createDescriptorBuilder(&descriptor_allocator);
    descriptorBuilder.bind_image(0, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE, VK_SHADER_STAGE_COMPUTE_BIT);
    //descriptorBuilder.bind_buffer(1, VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER, VK_SHADER_STAGE_COMPUTE_BIT);

    VkDescriptorSetLayout descriptorLayout = descriptorBuilder.buildLayout();

    compute_pipeline.descriptorSets.resize(1);
    compute_pipeline.descriptorSets[0].resize(swapchain.framesInFlight);

    //auto uniform_buffer_info = uniform_buffer.getBufferInfo();
    //descriptorBuilder.update_buffer(1, &uniform_buffer_info);
    
    VkDescriptorImageInfo imageInfo;
    imageInfo.sampler = VK_NULL_HANDLE;
    imageInfo.imageLayout = VK_IMAGE_LAYOUT_GENERAL;
    for (int i = 0; i < swapchain.framesInFlight; i++) {
        imageInfo.imageView = compute_images[i].view.value();
        descriptorBuilder.update_image(0, &imageInfo);
        compute_pipeline.descriptorSets[0][i] = descriptorBuilder.buildSet();
    }

    return descriptorLayout; 
}

void application::drawFrame() {
    uint32_t imageIndex;
    VkResult result = sync.acquireNextImage(swapchain.currentFrame,swapchain.swapChain,imageIndex);
    if (result == VK_ERROR_OUT_OF_DATE_KHR) {
        recreateSwapchain();
        return;
    } else if (result != VK_SUCCESS && result != VK_SUBOPTIMAL_KHR) {
        throw std::runtime_error("failed to acquire swap chain image!");
    }

    vkResetCommandBuffer(swapchain.commandBuffers[swapchain.currentFrame], 0);

    //COMMANDBUFFER RECORD

    VkCommandBufferBeginInfo beginInfo{};
    beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;

    if (vkBeginCommandBuffer(swapchain.commandBuffers[swapchain.currentFrame], &beginInfo) != VK_SUCCESS) {
        throw std::runtime_error("failed to begin recording command buffer!");
    }

    VkImageMemoryBarrier barrier{};
    barrier.sType = VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER;
    barrier.srcAccessMask = 0;
    barrier.dstAccessMask = VK_ACCESS_MEMORY_READ_BIT;
    barrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
    barrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
    barrier.subresourceRange.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
    barrier.subresourceRange.baseMipLevel = 0;
    barrier.subresourceRange.levelCount = 1;
    barrier.subresourceRange.baseArrayLayer = 0;
    barrier.subresourceRange.layerCount = 1;

    barrier.image = compute_images[swapchain.currentFrame].image; 
    barrier.oldLayout = VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL;
    barrier.newLayout = VK_IMAGE_LAYOUT_GENERAL;

    vkCmdPipelineBarrier(
            swapchain.commandBuffers[swapchain.currentFrame],
            VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT,
            VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
            0,
            0, nullptr,
            0, nullptr,
            1, &barrier
            );

    vkCmdBindPipeline(swapchain.commandBuffers[swapchain.currentFrame], VK_PIPELINE_BIND_POINT_COMPUTE, compute_pipeline.computePipeline);

    vkCmdBindDescriptorSets(
            swapchain.commandBuffers[swapchain.currentFrame], VK_PIPELINE_BIND_POINT_COMPUTE,
            compute_pipeline.pipelineLayout, 0, 1, 
            &compute_pipeline.descriptorSets[0][swapchain.currentFrame], 0, 0);

    vkCmdPushConstants(swapchain.commandBuffers[swapchain.currentFrame], compute_pipeline.pipelineLayout, VK_SHADER_STAGE_COMPUTE_BIT, 0, sizeof(push), &push);

    vkCmdDispatch(swapchain.commandBuffers[swapchain.currentFrame], static_cast<uint32_t>(std::ceil(static_cast<float>(swapchain.swapChainExtent.width)/32.f)), static_cast<uint32_t>(std::ceil(static_cast<float>(swapchain.swapChainExtent.height)/32.f)), 1);

    barrier.image = compute_images[swapchain.currentFrame].image; 
    barrier.oldLayout = VK_IMAGE_LAYOUT_GENERAL;
    barrier.newLayout = VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL;

    vkCmdPipelineBarrier(
            swapchain.commandBuffers[swapchain.currentFrame],
            VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
            VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT,
            0,
            0, nullptr,
            0, nullptr,
            1, &barrier
            );

    barrier.image = swapchain.swapChainImages[swapchain.currentFrame]; 
    barrier.oldLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR;
    barrier.newLayout = VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL;

    vkCmdPipelineBarrier(
            swapchain.commandBuffers[swapchain.currentFrame],
            VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
            VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT,
            0,
            0, nullptr,
            0, nullptr,
            1, &barrier
            );

    VkImageBlit blitRegion = {};
    blitRegion.srcOffsets[0] = { 0, 0, 0 };
    blitRegion.srcOffsets[1] = { (int)swapchain.swapChainExtent.width, (int)swapchain.swapChainExtent.height, 1 };
    blitRegion.srcSubresource.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
    blitRegion.srcSubresource.mipLevel = 0;
    blitRegion.srcSubresource.baseArrayLayer = 0;
    blitRegion.srcSubresource.layerCount = 1;

    blitRegion.dstOffsets[0] = { 0, 0, 0 };
    blitRegion.dstOffsets[1] = { (int)swapchain.swapChainExtent.width, (int)swapchain.swapChainExtent.height, 1 };
    blitRegion.dstSubresource.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
    blitRegion.dstSubresource.mipLevel = 0;
    blitRegion.dstSubresource.baseArrayLayer = 0;
    blitRegion.dstSubresource.layerCount = 1;

    vkCmdBlitImage(swapchain.commandBuffers[swapchain.currentFrame], compute_images[swapchain.currentFrame].image, VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL, swapchain.swapChainImages[swapchain.currentFrame], VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL, 1, &blitRegion, VK_FILTER_LINEAR);

    barrier.image = swapchain.swapChainImages[swapchain.currentFrame]; 
    barrier.oldLayout = VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL;
    barrier.newLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR;

    vkCmdPipelineBarrier(
            swapchain.commandBuffers[swapchain.currentFrame],
            VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
            VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT,
            0,
            0, nullptr,
            0, nullptr,
            1, &barrier
            );



    if (vkEndCommandBuffer(swapchain.commandBuffers[swapchain.currentFrame]) != VK_SUCCESS) {
        throw std::runtime_error("failed to record command buffer!");
    }
    //command buffer record end

    sync.submitFrame(swapchain.currentFrame,1,&swapchain.commandBuffers[swapchain.currentFrame],instance.graphicsQueue);

    result = sync.presentFrame(swapchain.currentFrame,imageIndex,swapchain.swapChain,instance.presentQueue);

    if (result == VK_ERROR_OUT_OF_DATE_KHR || result == VK_SUBOPTIMAL_KHR || window.frameBufferResized() ) {
        recreateSwapchain();
    } else if (result != VK_SUCCESS) {
        throw std::runtime_error("failed to present swap chain image!");
    }

    swapchain.currentFrame = (swapchain.currentFrame + 1) % swapchain.framesInFlight;
}

void application::loop() {

    auto start = std::chrono::high_resolution_clock::now();

    auto end = std::chrono::high_resolution_clock::now();

    double prevTime = 0.0f;
    double time = 0.;
    double deltaTime = 0.;

    auto updateDeltaTime = [&]() {
        end = std::chrono::high_resolution_clock::now();
        time = std::chrono::duration<double>(end - start).count();
        deltaTime = time - prevTime;
        prevTime = time;
    };


    //auto updateUniform = [&](){
    //    uniform.update(camera);
    //    memcpy(uniform_buffer.allocInfo.pMappedData, &uniform, sizeof(ubo));
    //};

    window.setWindowUserPointer(&camera);
    glfwSetCursorPosCallback(window.win, mouse_callback);
    glfwSetInputMode(window.win, GLFW_CURSOR, GLFW_CURSOR_DISABLED);

    std::ofstream stream;
    stream.open("fps.log");

    auto calcFps = [&]() {
        std::string title("Vulkan FPS: "); 
        title += std::to_string(1./deltaTime);
        stream << title << std::endl;
        //glfwSetWindowTitle(window.win,title.c_str());
    };
    
    while (!window.shouldClose()) {

        glfwPollEvents();

        updateDeltaTime();
        camera.update();
        push.update(camera);

        if (glfwGetKey(window.win, GLFW_KEY_W) == GLFW_PRESS) {
            camera.move(gllib::camera::movement::forward, deltaTime);
        }
        if (glfwGetKey(window.win, GLFW_KEY_S) == GLFW_PRESS) {
            camera.move(gllib::camera::movement::backward, deltaTime);
        }
        if (glfwGetKey(window.win, GLFW_KEY_A) == GLFW_PRESS) {
            camera.move(gllib::camera::movement::left, deltaTime);
        }
        if (glfwGetKey(window.win, GLFW_KEY_D) == GLFW_PRESS) {
            camera.move(gllib::camera::movement::right, deltaTime);
        }
        if (glfwGetKey(window.win, GLFW_KEY_SPACE) == GLFW_PRESS) {
            camera.move(gllib::camera::movement::down, deltaTime);
        }
        if (glfwGetKey(window.win, GLFW_KEY_LEFT_SHIFT) == GLFW_PRESS) {
            camera.move(gllib::camera::movement::up, deltaTime);
        }
        if (glfwGetKey(window.win, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
            captured = true;
            glfwSetCursorPosCallback(window.win, mouse_callback);
            glfwSetInputMode(window.win, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
        }
        if (glfwGetKey(window.win, GLFW_KEY_1) == GLFW_PRESS) {
            captured = false;
            glfwSetCursorPosCallback(window.win, nullptr);
            glfwSetInputMode(window.win, GLFW_CURSOR, GLFW_CURSOR_NORMAL);
        }


        //std::cout << push.direction[0] << "," << push.direction[1] << "," << push.direction[2] << std::endl;

        drawFrame();

        threadpool->add_task([&](){
            calcFps();
        });

    }

    instance.waitForDeviceIdle();
    stream.close();
}

void application::swapchainPipelineBarrier() {
    auto command_pool = instance.getCommandPool();
    
    VkCommandBuffer command_buffer = instance.beginSingleTimeCommands(command_pool.get());

    VkImageMemoryBarrier barrier = {};
    barrier.sType = VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER;
    barrier.srcAccessMask = 0;
    barrier.dstAccessMask = VK_ACCESS_MEMORY_READ_BIT;
    barrier.oldLayout = VK_IMAGE_LAYOUT_UNDEFINED;
    barrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
    barrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
    barrier.subresourceRange.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
    barrier.subresourceRange.baseMipLevel = 0;
    barrier.subresourceRange.levelCount = 1;
    barrier.subresourceRange.baseArrayLayer = 0;
    barrier.subresourceRange.layerCount = 1;

    for (int i = 0; i < swapchain.framesInFlight; i++) {
        barrier.image = swapchain.swapChainImages[i]; 
        barrier.newLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR;

        vkCmdPipelineBarrier(
                command_buffer,
                VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
                VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
                0,
                0, nullptr,
                0, nullptr,
                1, &barrier
                );
                barrier.image = swapchain.swapChainImages[i]; 

        barrier.image = compute_images[i].image; 
        barrier.newLayout = VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL;

        vkCmdPipelineBarrier(
                command_buffer,
                VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
                VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
                0,
                0, nullptr,
                0, nullptr,
                1, &barrier
                );
    }

    instance.endSingleTimeCommands(command_pool.get(), command_buffer);
    
}

void application::recreateSwapchain() {
    
    int width = 0, height = 0;
    glfwGetFramebufferSize(window.win, &width, &height);
    while (width == 0 || height == 0) {
        glfwGetFramebufferSize(window.win, &width, &height);
        glfwWaitEvents();
    }


    instance.waitForDeviceIdle();

    swapchain.recreateSwapChain();

    for (int i = 0; i < swapchain.framesInFlight; i++) {
        instance.destroyImage(compute_images[i]);

        compute_images[i] = instance.createComputeImage(VK_IMAGE_TYPE_2D, {swapchain.swapChainExtent.width,swapchain.swapChainExtent.height,1});
        instance.createImageView(compute_images[i], VK_FORMAT_R8G8B8A8_UNORM, VK_IMAGE_VIEW_TYPE_2D, VK_IMAGE_ASPECT_COLOR_BIT);
    }

    swapchainPipelineBarrier();

    createDescriptorSets();

    camera.update_aspect(static_cast<float>(width)/static_cast<float>(height));

}

} //namespace convolution
