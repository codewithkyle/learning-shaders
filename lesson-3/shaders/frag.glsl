#version 330

out vec4 finalColor;

in vec2 vUvs;

void main() {
    vec3 color = vec3(0.0);
    //color = vec3(vUvs.x);
    color = vec3(step(0.25, vUvs.x));
    finalColor = vec4(color, 1.0);
}
