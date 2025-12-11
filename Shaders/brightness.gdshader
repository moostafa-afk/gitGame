shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform float brightness = 4;

void fragment() {
    vec4 c = texture(TEXTURE, UV);
    vec4 brightness_color = vec4(c.r * brightness, c.g * brightness, c.b * brightness, c.a * brightness);
    COLOR = brightness_color;
	// Called for every pixel the material is visible on.
}

void light() {


}
