shader_type canvas_item;
#include "res://addons/shaderV/rgba/generate_shapes/chekerboardPattern.gdshaderinc"

// Use SCREEN_UV for Line2D (no texture). Set to false for Sprite2D if you prefer UV.
uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float line_thickness : hint_range(0.0, 1000.0) = 1.0;
uniform float spacing : hint_range(0.0, 10.0) = 2.0;
uniform float speed : hint_range(-10.0, 1000) = 1.0; // pixels per second

uniform bool use_screen_uv = true;
uniform vec2 tiles = vec2(10.0, 10.0);    // how many shapes across the screen/texture
uniform float slant = 0.5;                // shear amount (+ right, - left)

uniform vec4 color_a : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color_b : source_color = vec4(0.0, 0.0, 0.0, 1.0);

// Optional: make the “odd” cells transparent instead of color_b
uniform bool transparent_b = false;

void fragment() {
    // Choose coordinate space
    vec2 uv = use_screen_uv ? SCREEN_UV : UV;

    // Scale to grid units
    vec2 g = uv * tiles;

    // Apply shear to turn rectangles into parallelograms
    g.x += g.y * slant ;
    g.y += speed *TIME;

    // Integer cell indices in the sheared grid
    vec2 ij = floor(g);

    // Alternate cells: 0 or 1
    float mask = mod(ij.x + ij.y, 2.0);

    // Pick color
    vec4 col = mix(color_a, color_b, mask);

    // Optional transparency for the “odd” cells
    if (transparent_b && mask > 0.5) {
        col.a = 0.0;
    }



    COLOR = col;
    
    
}    
