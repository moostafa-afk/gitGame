shader_type canvas_item;

uniform vec4 target_color : source_color;
uniform vec4 replce_color : source_color;
uniform float tolerance : hint_range(0, 1);

uniform vec4 target_color_2 : source_color;
uniform vec4 replce_color_2 : source_color;
uniform float tolerance_2 : hint_range(0, 1);

uniform vec4 target_color_3 : source_color;
uniform vec4 replce_color_3 : source_color;
uniform float tolerance_3 : hint_range(0, 1);

uniform vec4 glow_color : source_color;
uniform float glow_power: hint_range(0.0, 100.0, .1) = 2.0;
uniform float glow_shift: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float glow_radius: hint_range(1.0, 50.0, 1.0) = 1.0;

// helper function: applies color replacement to a sampled pixel
vec4 apply_replacements(vec4 c) {
    if (distance(c.rgb, target_color.rgb) < tolerance)
        c.rgb = replce_color.rgb;
    else if (distance(c.rgb, target_color_2.rgb) < tolerance_2)
        c.rgb = replce_color_2.rgb;
    else if (distance(c.rgb, target_color_3.rgb) < tolerance_3)
        c.rgb = replce_color_3.rgb;
    return c;
}

void fragment() {
    vec4 tex_color = apply_replacements(texture(TEXTURE, UV));

    // build glow from replaced colors instead of raw texture
    vec4 glow = vec4(0.0);
    float count = 0.0;
    for (float x = -glow_radius; x <= glow_radius; x += 1.0) {
        for (float y = -glow_radius; y <= glow_radius; y += 1.0) {
            vec2 offset = vec2(x, y) * glow_shift * TEXTURE_PIXEL_SIZE;
            glow += apply_replacements(texture(TEXTURE, UV + offset)) * glow_color;
            count += 1.0;
        }
    }
    glow *= glow_power / count;

    COLOR = mix(tex_color, glow, glow.a);
}
