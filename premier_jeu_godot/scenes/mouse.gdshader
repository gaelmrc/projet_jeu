shader_type canvas_item;

uniform bool is_white = false;

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE.xy;
    vec4 tex_color = texture(TEXTURE, uv);
    if (is_white) {
        COLOR = vec4(1.0, 1.0, 1.0, tex_color.a);
    } else {
        COLOR = tex_color;
    }
}
