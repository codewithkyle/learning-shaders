#version 330

in vec2 uvs;

out vec4 finalColor;

uniform sampler2D diffuse;
uniform vec4 tint;

void main() {
    vec4 diffuseSample = texture2D(diffuse, uvs);
    finalColor = diffuseSample * tint;
}
