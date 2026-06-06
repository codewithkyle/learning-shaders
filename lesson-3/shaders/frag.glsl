#version 330

out vec4 finalColor;

in vec2 vUvs;

void main() {
    vec3 color = vec3(0.0);
    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);
    vec3 green = vec3(0.0, 1.0, 0.0);
    vec3 white = vec3(1.0);

    float value1 = 1.0 - vUvs.x;
    float value2 = smoothstep(0.0, 1.0, value1);

    float line = smoothstep(0.0, 0.005, abs(vUvs.y - 0.5));
    float linearline = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.5, 1.0, value1)));
    float smoothline = smoothstep(0.0, 0.0075, abs(vUvs.y + 0.5 - mix(0.5, 1.0, value2)));

    if (vUvs.y > 0.5) {
        color = mix(red, blue, vUvs.x);
    }
    else
    {
        color = mix(red, blue, smoothstep(0.0, 1.0, vUvs.x));
    }

    color = mix(white, color, line);
    color = mix(white, color, linearline);
    color = mix(white, color, smoothline);

    finalColor = vec4(color, 1.0);
}
