#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 in_pos;
layout(location = 1) in vec3 in_nor;
layout(location = 2) in vec2 in_uv;

// frag shader output color
layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    
    // diffuse lighting
    vec3 lightDir = normalize(vec3(0.3, 1.0, 0.6));
    vec3 col1 = vec3(0.49, 0.63, 0.0);
    vec3 col2 = vec3(0.27, 0.56, 0.13);

    float diffuse = max(dot(in_nor, lightDir), 0.0);
    float ambient = 0.2;

    vec3 col = col2 * (diffuse * (1.0 - ambient) + ambient);

    outColor = vec4(1.0);
}
