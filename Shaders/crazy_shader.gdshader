shader_type canvas_item;
uniform vec4 outline_color : source_color = vec4(1.0);

uniform bool GLOW_active = true;
uniform vec4 glow_color : source_color;
uniform float glow_power: hint_range(0.0, 100.0, .1) = 2.0;
uniform float glow_shift: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float glow_radius: hint_range(1.0, 50.0, 1.0) = 1.0;
uniform float progress : hint_range(0, 1);
uniform float block_size = 1;

float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 438.5453);
}

vec4 glow(in vec2 uv, in sampler2D tex, in vec2 pix_size, inout vec4 color) {
	vec4 glow = vec4(0.0);
	float count = 0.0;
	for (float x = -glow_radius; x <= glow_radius; x += 1.0) {
		for (float y = -glow_radius; y <= glow_radius; y += 1.0) {
			vec2 offset = vec2(x, y) * glow_shift * pix_size;
			glow += texture(tex, uv + offset) * glow_color;
			count += 1.0;
		}
	}
	glow *= glow_power / count;
	color = mix(texture(tex, uv), glow, glow.a) ;
    return color;
}

void fragment() {
	vec2 pixel_size = TEXTURE_PIXEL_SIZE;
	bool within = texture(TEXTURE, UV + pixel_size * vec2(1.0, 0.0)).a > 0.0;
	within = within || texture(TEXTURE, UV + pixel_size * vec2(1.0, 1.0)).a > 0.0;
	within = within || texture(TEXTURE, UV + pixel_size * vec2(1.0, -1.0)).a > 0.0;
	within = within || texture(TEXTURE, UV + pixel_size * vec2(0.0, -1.0)).a > 0.0;
	within = within || texture(TEXTURE, UV + pixel_size * vec2(0.0, 1.0)).a > 0.0;
	within = within || texture(TEXTURE, UV + pixel_size * vec2(-1.0, 1.0)).a > 0.0;
	within = within || texture(TEXTURE, UV + pixel_size * vec2(-1.0, -1.0)).a > 0.0;
	within = within || texture(TEXTURE, UV + pixel_size * vec2(-1.0, 0.0)).a > 0.0;
	bool outline = within && texture(TEXTURE, UV).a == 0.0;
// pixeltion AND texture exclusion
    vec4 color2 = vec4(SCREEN_UV,1.,1.) - texture(TEXTURE, UV);
	vec2 uv_snapped = floor(UV / TEXTURE_PIXEL_SIZE / vec2(block_size));
	color2.a *= step(progress, random(uv_snapped));
    
    vec4 glow =  glow(UV,TEXTURE,TEXTURE_PIXEL_SIZE,COLOR );
	COLOR= float(!outline) * COLOR + float(outline) * outline_color* color2 * glow ;
    
}
