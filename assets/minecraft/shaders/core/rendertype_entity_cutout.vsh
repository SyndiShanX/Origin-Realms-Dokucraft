#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>
#moj_import <h.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0, Sampler1, Sampler2;

uniform mat4 ModelViewMat, ProjMat;
uniform vec2 ScreenSize;
uniform int FogShape;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightMapColor;
out vec4 overlayColor;
out vec2 texCoord0;
out float effect;

#moj_import <a.glsl>

void main() {
  texCoord0 = UV0;
  if (A_test()) {
    effect = 4.;
    gl_Position = A_transform();
    vertexDistance = 0.;
    lightMapColor = vec4(1.);
    overlayColor = vec4(1.);
    vertexColor = vec4(1.);
  } else {
    effect = 0.;
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    vertexDistance = fog_distance(Position, FogShape);
    lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
    overlayColor = texelFetch(Sampler1, UV1, 0);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
  }
}
