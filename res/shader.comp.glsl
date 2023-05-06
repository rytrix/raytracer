#version 450

layout (local_size_x = 32, local_size_y = 32, local_size_z = 1) in;

layout (binding = 0, rgba8) uniform image2D currentImage;
//layout (std140, binding = 1) uniform uboData {
//    mat4 inverse_proj;
//    mat4 inverse_view;
//    vec3 pos;
//} ubo;

layout (push_constant) uniform PushConstant {
    mat4 inverse_proj_view;
    vec3 pos;
} pushConstant;

struct sphere {
    vec3 pos;
    float radius;
    vec3 albedo;
};

const sphere spheres[] = {
    {vec3(1.0),1.0,vec3(1.0)},
    {vec3(2.5),0.3,vec3(0.0,0.5,0.5)},
    {vec3(5.5),0.5,vec3(0.0,0.5,1.0)},
    {vec3(8.5),1.0,vec3(0.0,0.5,0.0)},
};
const int sphere_count = 4;

const vec3 light_source = vec3(2.0);

//traverse ray (might need to normalize)
//vec3 traverse_ray(vec3 pos, vec3 dir, float steps) {
//    return pos + (dir*steps);
//}

void main() {
    ivec2 texel = ivec2(gl_GlobalInvocationID.xy);
   // imageStore(currentImage, texel, vec4(1.0));
   // return;
    
    vec2 texture_size = imageSize(currentImage); 
    vec2 coord = ((vec2(texel)/texture_size) * 2.0) - 1.0;


    //vec4 target = ubo.inverse_proj * vec4(coord.xy, 1.0, 1.0);
    //vec3 ray_dir = vec3(ubo.inverse_view * vec4(normalize(vec3(target)/target.w),0.0));

    vec4 target = pushConstant.inverse_proj_view * vec4(coord.xy, 1.0, 1.0);
    vec3 ray_dir = normalize(target.xyz/target.w);
    //vec3 ray_dir = vec3(1.0);

    float closestT0 = 0.0;
    vec3 closest_pos = vec3(0.0);
    int closestSphere = -1; 

    bool first = true;
    
    for (int i = 0; i < sphere_count; i++) {
        vec3 ubo_pos = pushConstant.pos-spheres[i].pos;
        float a = dot(ray_dir, ray_dir);
        float b = 2.0 * dot(ubo_pos, ray_dir);
        float c = dot(ubo_pos, ubo_pos) - spheres[i].radius * spheres[i].radius;

        float discriminate = b * b - 4.0f * a * c;

        if (discriminate >= 0.0f) {
            float t0 = (-b - sqrt(discriminate)) / (2.0 * a); //always the smallest FYI
            //float t1 = (-b + sqrt(discriminate)) / (2.0 * a);
            if (t0 >= 0 && (t0 < closestT0 || first == true)) {
                first = false;
                closestT0 = t0;
                closestSphere = i;
                closest_pos = ubo_pos;
            }
        }

    }

    if (closestSphere == -1) {
        imageStore(currentImage, texel, vec4(0.3));
        return;
    }

    //if (closestT0 < 0) {
    //    imageStore(currentImage, texel, vec4(0.3));
    //    return;
    //}

    vec3 hit_pos = closest_pos + ray_dir * closestT0;
    vec3 normal = normalize(hit_pos);

    vec3 light_direction = normalize(light_source);
    float light_intensity = max(dot(normal,-light_direction),0.10); //=cos(angle) 


    imageStore(currentImage, texel, vec4(spheres[closestSphere].albedo*light_intensity,1.0));
    //} else {
    //    imageStore(currentImage, texel, vec4(0.0));
    //}

    
}


