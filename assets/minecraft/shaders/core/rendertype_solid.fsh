#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec4 normal;
in vec4 shadeColor;

out vec4 fragColor;

void main() {
    vec4 rgb = texture(Sampler0, texCoord0);
    float e = sign(abs(rgb.a - 254. / 255.));
    rgb.a = mix(1., rgb.a, e);
    vec4 color = rgb * mix(shadeColor, vertexColor, e) * ColorModulator;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
