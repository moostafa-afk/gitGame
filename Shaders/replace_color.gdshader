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
void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    
    float dist = distance(tex_color.rgb,target_color.rgb);
    if (dist < tolerance){
        tex_color.rgb = replce_color.rgb;
        }
        
    float dist_2 = distance(tex_color.rgb,target_color_2.rgb);
    if (dist_2 < tolerance_2){
        tex_color.rgb = replce_color_2.rgb ;
        }
        
    float dist_3 = distance(tex_color.rgb,target_color_3.rgb);
    if (dist_3 < tolerance_3){
        tex_color.rgb = replce_color_3.rgb ;
     }
    
    COLOR = tex_color;
         
    }
    
    

