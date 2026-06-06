#version 330

out vec4 finalColor;

in vec2 vUvs;

void main() {
    vec3 color = vec3(0.0);
    vec3 red = vec3(1.0, 0.0, 0.0);
    //color = vec3(vUvs.x);
    //color = vec3(step(0.25, vUvs.x));
    //color = mix(red, color, vUvs.x);
    //color = vec3(smoothstep(0.0, 1.0, vUvs.x));
    color = mix(red, color, smoothstep(0.0, 1.0, vUvs.x));

    finalColor = vec4(color, 1.0);
}
