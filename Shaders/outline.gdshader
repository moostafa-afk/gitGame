shader_type canvas_item;

uniform bool GLOW_active = true;
uniform vec4 glow_color : source_color;
uniform float glow_power: hint_range(0.0, 100.0, .1) = 2.0;
uniform float glow_shift: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float glow_radius: hint_range(1.0, 50.0, 1.0) = 1.0;
uniform float progress : hint_range(0, 1);
uniform float block_size = 1;

//OUTLINE
uniform bool  OUTLINE_active  = true;
uniform float OUTLINE_thickness : hint_range(0, 30) = 20.0;
uniform vec4  OUTLINE_color : source_color = vec4(1,0,0,1);

float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 438.5453);
}

vec4 outline(in vec2 uv, in sampler2D tex, in vec2 s, in vec2 spriteSize , inout vec4 color) {

    vec2 size = vec2(OUTLINE_thickness) / spriteSize;
    float alpha = color.a;
    alpha += texture(tex, uv + vec2(0.0, -size.y)).a;
    alpha += texture(tex, uv + vec2(size.x, -size.y)).a;
    alpha += texture(tex, uv + vec2(size.x, 0.0)).a;
    alpha += texture(tex, uv + vec2(size.x, size.y)).a;
    alpha += texture(tex, uv + vec2(0.0, size.y)).a;
    alpha += texture(tex, uv + vec2(-size.x, size.y)).a;
    alpha += texture(tex, uv + vec2(-size.x, 0.0)).a;
    alpha += texture(tex, uv + vec2(-size.x, -size.y)).a;

    vec3 final_color = mix(OUTLINE_color.rgb, color.rgb, color.a);
    return color = vec4(final_color, clamp(alpha, 0.0, 1.0));
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
//outline
// pixeltion AND texture exclusion
	vec2 size = vec2(textureSize(TEXTURE, 0));
    vec4 color2 = vec4(SCREEN_UV,1.,1.) - texture(TEXTURE, UV);
	vec2 uv_snapped = floor(UV / TEXTURE_PIXEL_SIZE / vec2(block_size));
	color2.a *= step(progress, random(uv_snapped));

    //vec4 glow =  glow(UV,TEXTURE,TEXTURE_PIXEL_SIZE,COLOR );
	outline(UV,TEXTURE,size,TEXTURE_PIXEL_SIZE,COLOR )    ;

}
