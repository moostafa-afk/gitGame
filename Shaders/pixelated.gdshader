shader_type canvas_item;

#include "res://addons/shaderV/uv/pixelate.gdshaderinc"

uniform vec4 line_color : source_color = vec4(1.0,1.0,1.0,1.0);
uniform vec2 effect_factor_pixelate = vec2(50.0, 50.0);

void fragment() {
    vec2 uv = SCREEN_UV; // okay
    vec2 pixCoord = _pixelateUV(uv, effect_factor_pixelate);
    COLOR = line_color * vec4(vec3(fract(pixCoord.x + pixCoord.y)), 1.0);
}
