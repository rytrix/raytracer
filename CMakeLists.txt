set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/res DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  add_compile_definitions(_DEBUG)
endif()

cmake_minimum_required(VERSION 3.22.0)

project(raytracer)

add_executable(${PROJECT_NAME} src/main.cpp src/raytracer_app.cpp src/camera.cpp)

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_20)

add_subdirectory(svklib)

target_link_libraries(${PROJECT_NAME} svklib)

target_include_directories(${PROJECT_NAME} 
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/svklib/svklib
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/svklib/dep/glm
)



