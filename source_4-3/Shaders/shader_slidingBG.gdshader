shader_type canvas_item;
uniform vec2 rate;

void fragment() {
	COLOR = texture(TEXTURE, UV + rate*TIME).rgba;
}
