shader_type canvas_item;

uniform float low_health_amount : hint_range(0.0, 1.0) = 0.0;
uniform vec4 low_health_color : source_color = vec4(1.0, 1.0, 0.0, 1.0);

uniform float damage_amount : hint_range(0.0, 1.0) = 0.0;
uniform vec4 damage_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    vec3 color = tex.rgb;
    color = mix(color, low_health_color.rgb, low_health_amount);
    color = mix(color, damage_color.rgb, damage_amount);

    COLOR = vec4(color, tex.a);
}