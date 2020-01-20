shader_type canvas_item;

void fragment() {
	vec4 color = textureLod(TEXTURE, UV, 0.0);
	color.r = 1.0;
	COLOR = vec4(1.0, 0.0, 0.0, 1.0);
}