#version 330

in vec2 uvs;

out vec4 finalColor;

uniform sampler2D diffuse;
uniform sampler2D overlay;
uniform vec4 tint;

void main() {
    vec2 uvs_scaled = uvs / 10.0;
    vec4 diffuseSample = texture2D(diffuse, uvs_scaled);
    vec4 overlaySample = texture2D(overlay, uvs);
    finalColor = mix(diffuseSample, overlaySample, overlaySample.w);
}
