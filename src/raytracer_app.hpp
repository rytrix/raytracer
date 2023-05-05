#include "svk_descriptor.hpp"
#include "svk_renderer.hpp"
#include "svk_threadpool.hpp"
#include "svklib.hpp"
#include <memory>
#include "glm/glm.hpp"

#include "camera.hpp"

namespace raytracer {

class application {
    public:
        application();
        ~application();

        void createPipeline();
        VkDescriptorSetLayout createDescriptorSets();

        void drawFrame();
        void loop();
    
        svklib::window window;
        svklib::instance instance;
        svklib::swapchain swapchain;

        svklib::compute::pipeline compute_pipeline;

        svklib::descriptor::allocator::pool descriptor_allocator;
        std::vector<VkDescriptorSet> descriptor_sets;

        svklib::queue::sync sync;

        gllib::camera camera;
        std::vector<svklib::instance::svkimage> compute_images;


    
    private:
        svklib::threadpool* threadpool;

        void swapchainPipelineBarrier();
        void recreateSwapchain();

        struct push_constant {
            glm::mat4 inverse_proj_view;
            glm::vec3 pos;

            inline void update(gllib::camera& camera) {
                inverse_proj_view = camera.get_inverse_proj_view();
                pos = camera.get_pos();
            }
        };

        push_constant push;

        struct ubo {
            glm::mat4 inverse_proj;
            glm::mat4 inverse_view;
            glm::vec3 pos;

            inline void update(gllib::camera& camera) {
                inverse_proj = camera.get_inverse_proj();
                inverse_view = camera.get_inverse_view();
                pos = camera.get_pos();
            }
        };

        ubo uniform;
        svklib::instance::svkbuffer uniform_buffer;


}; //class application

} //namespace convolution
