shader_type canvas_item;

uniform int samples = 35;                // number of samples
uniform int lod = 2;                     // level of detail
uniform vec4 line_color : source_color = vec4(1.0,1.0,1.0,1.0); // line color

float gaussian(vec2 offset, float sigma) {
    offset /= sigma;
    return exp(-0.5 * dot(offset, offset) / (2.0 * 3.14159265 * sigma * sigma));
}

// Replace texture sampling with procedural node color
vec4 get_source_color() {
    return line_color;
}

void fragment() {
    float sigma = float(samples) * 0.25;
    int sLOD = 1 << lod;
    int s = samples / sLOD;

    vec4 color = vec4(0.0);

    for (int i = 0; i < s * s; i++) {
        // Compute sample offsets
        vec2 offset = vec2(float(i % s), float(i / s)) * float(sLOD) - float(samples) / 2.0;

        // Use FRAGCOORD for pixel position
        vec2 sample_coord = FRAGCOORD.xy + offset;

        // Normalize to [0,1] if needed (optional)
        // vec2 normalized = sample_coord / VIEWPORT_SIZE; // not needed, using direct color

        // Add weighted color
        color += gaussian(offset, sigma) * get_source_color();
    }

    // Normalize by alpha if necessary
    COLOR = color;
    if (color.a > 0.0) {
        COLOR /= color.a;
    }
}
