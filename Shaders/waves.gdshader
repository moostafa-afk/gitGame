shader_type canvas_item;

uniform float time;

void vertex() {
    VERTEX.y += sin(VERTEX.x * 0.1 + time) * 5.0;
}
