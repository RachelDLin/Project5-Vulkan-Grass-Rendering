#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_v1[];
layout(location = 1) in vec4 in_v2[];
layout(location = 2) in vec4 in_up[];

layout(location = 0) out vec3 out_pos;
layout(location = 1) out vec3 out_nor;
layout(location = 2) out vec2 out_uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

}
