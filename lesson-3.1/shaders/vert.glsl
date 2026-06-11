#version 330

in vec3 vertexPosition;
in vec2 vertexTexCoord;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;

out vec2 vUvs;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vertexPosition, 1.0);
    vUvs = vertexTexCoord;
}
