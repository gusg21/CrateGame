shader_type canvas_item;

uniform float offset;
uniform float repeats;

void fragment() {
	COLOR.r = mod(UV.x * repeats + offset, 1.0);
	COLOR.g = mod((UV.x + 1.0/(repeats * 3.0)) * repeats + offset, 1.0);	
	COLOR.b = mod((UV.x + 2.0/(repeats * 3.0)) * repeats + offset, 1.0);	
}