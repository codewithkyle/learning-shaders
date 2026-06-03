#version 330

out vec4 finalColor;

in vec2 vUvs;

uniform vec4 color1;
uniform vec4 color2;

void main() {
    finalColor = mix(
        color1,
        color2,
        vUvs.x
    );
}
