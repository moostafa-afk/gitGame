shader_type canvas_item;
#include "res://addons/shaderV/rgba/generate_shapes/chekerboardPattern.gdshaderinc"

uniform float speed : hint_range(0.0, 1.0, .1);
uniform float alpha : hint_range(0.0,1.0,.1);
uniform vec4 line_color : source_color = vec4(1.0);
//uniform vec2 effect_factor_pixelate = vec2(50.0,50.0); // pixelation intensity
uniform vec2 checker_size = vec2(10.0,10.0);          // checkerboard cell count

void fragment() {
    vec4 sprite = texture(TEXTURE,UV);
    vec2 uv = UV;
    uv.xy += TIME * speed;           // apply movement

    // Generate the checkerboard pattern
    float checker = _checkerboardPatternFunc(uv, checker_size);

    // Set color
    vec3 baseColor = line_color.rgb;
    // If checker == 1 → keep color, if 0 → make transparent
    COLOR = vec4(baseColor , checker* alpha ) * sprite;
}


