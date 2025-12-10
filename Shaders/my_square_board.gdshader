shader_type canvas_item;
uniform float width :hint_range(0.0, 1.0, 0.1);
uniform float height :hint_range(0.0, 1.0, 0.1);
uniform vec4 color : source_color;
uniform float glow_intensity : hint_range(0.0, 100.0, 0.01);

void fragment() {
    // Normalize UV from [0,1] → [-1,1]
    vec2 uv = vec2(UV.x * 2.0 - 1.0 , UV.y * 2. -1.0);
    // Inside X bounds?
    float insideX = step(-width, uv.x) * step(uv.x, width);

    // Inside Y bounds?
    float insideY = step(-height, uv.y) * step(uv.y, height);

    // Multiply → only 1.0 if inside both bounds
    float inside =  insideY * insideX;
    // Apply color only inside rectangle


    float glow =  (.01 / length(max((abs(uv)) - vec2(width, height), 0.0001)));
    COLOR = color  * glow * glow_intensity ;

}
