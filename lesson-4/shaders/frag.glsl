#version 330

out vec4 finalColor;

in vec2 vUvs;

uniform vec2 resolution;
uniform float time;

float inverseLerp(float v, float minValue, float maxValue) {
	return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
	float t = inverseLerp(v, inMin, inMax);
	return mix(outMin, outMax, t);
}

void main() {
	vec3 color = vec3(0.75);
	vec3 red = vec3(1.0, 0.0,0.0);
	vec3 blue = vec3(0.0,0.0,1.0);

	//float t = sin(time);
	//t = remap(t, -1.0, 1.0, 0.0, 1.0);
	//color = mix(red, blue, t);

	float t1 = sin(vUvs.x * 100.0);
	float t2 = sin((vUvs.y + time * 0.5) * 100.0);

	color = vec3(t1 * t2);

	finalColor = vec4(color, 1.0);
}
