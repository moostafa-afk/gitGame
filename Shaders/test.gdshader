shader_type canvas_item;

uniform float time_offset : hint_range(0.0, 1.0, 0.001) = 1.0;
uniform float dissolve_speed = 1.0;
uniform float min_value :hint_range(0,1) = .5;
uniform float max_value :hint_range(0,1) = .7;

float random_coord(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898,96.233))) * 43758.5453);
}
float sin_range(float x) {
    return min_value + (sin(x) * 0.5 + 0.5) * (max_value - min_value);
}

void fragment() {

	vec2 texture_resolution = 1.0 / TEXTURE_PIXEL_SIZE;
	vec2 pixel_within_texture = floor(UV * texture_resolution);
	vec4 texture_color = texture(TEXTURE, UV);

    float min_val = 0.7;
    float max_val = 0.8;

    float oscillating_value = min_val + (sin(TIME) + 1.0) * 0.5 * (max_val - min_val);

	if ((oscillating_value) * dissolve_speed < random_coord(pixel_within_texture)) {
		// Set to the original texture color
//		COLOR = texture_color;
		// Set to a new color
		COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	}


}