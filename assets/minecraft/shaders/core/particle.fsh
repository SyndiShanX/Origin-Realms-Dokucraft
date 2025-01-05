#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;
flat in float custom;

out vec4 fragColor;

void main() {
    vec4 col = texture(Sampler0, texCoord0);
    if (custom > 0.) {
        vec2 dim = vec2(textureSize(Sampler0, 0));
        vec2 uv = texCoord0 * dim;
        col = texture(Sampler0, (mod(uv, 8.) + vec2(
            mod(custom - 1., 16.),
            floor((custom - 1.) / 16.) * 8. + mod(floor(col.r * 255.), 8.)) * 8.) / dim);
    }
    vec4 color = col * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
