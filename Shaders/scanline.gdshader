shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float line_thickness : hint_range(0.0, 5.0) = 1.0;
uniform float spacing : hint_range(0.0, 10.0) = 2.0;
uniform float speed : hint_range(-10.0, 10.0) = 1.0; // pixels per second

void fragment() {
    float y = FRAGCOORD.y + TIME * speed;
    float pattern = mod(y, line_thickness + spacing);
    float mask = step(pattern, line_thickness);
    COLOR = vec4(color.rgba * mask);
}
