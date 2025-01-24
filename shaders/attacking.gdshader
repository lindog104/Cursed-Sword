shader_type canvas_item;

uniform float rate_of_flash = 2.0;
uniform float rate_of_vibrate = 25.0;

void vertex() {
	VERTEX.x -= sin(TIME * rate_of_vibrate);
}

void fragment() {
	COLOR.r = abs(tan(TIME * rate_of_flash));
}
