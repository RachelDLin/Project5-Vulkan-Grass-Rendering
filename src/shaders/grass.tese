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
    float u = gl_TessCoord.x; // along width
    float v = gl_TessCoord.y; // along blade

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 pos0 = gl_in[0].gl_Position.xyz;
    vec3 pos1 = in_v1[0].xyz;
    vec3 pos2 = in_v2[0].xyz;

    float dir = gl_in[0].gl_Position.w;
    vec3 rDir = normalize(vec3(cos(dir), 0, sin(dir)));
    vec3 uDir = in_up[0].xyz;
    vec3 fDir = normalize(cross(rDir, uDir));
    
    float height = in_v1[0].w;
    float width = in_v2[0].w;
    
    // quadratic bezier interpolation
    vec3 curvePos = (1.0 - v) * (1.0 - v) * pos0 + 
                    2.0 * (1.0 - v) * v * pos1 +
                    v * v * pos2;

    // width offset
    float interpolatedWidth = (1.0 - v) * width;
    vec3 bladePos = curvePos + (u - 0.5) * interpolatedWidth * rDir;

    // normal
    vec3 tangent = normalize(pos2 - pos0);
    vec3 normal = normalize(cross(tangent, rDir));

    // output
    gl_Position = camera.proj * camera.view * vec4(bladePos, 1.0);
    out_pos = bladePos;
    out_nor = normal;
    out_uv = vec2(u, v);
}
