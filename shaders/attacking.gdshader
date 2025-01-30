shader_type canvas_item;

uniform float rate_of_flash = 3.0;
uniform float rate_of_vibrate = 40.0;

// Called for every vertex of the image
// Makes the whole image jitter left and right
void vertex() {
	// Move the vertex left and right
	// rate_of_vibrate is the speed of movement
	VERTEX.x -= sin(TIME * rate_of_vibrate);
}

// Called for every pixel in the image
// Makes the image flash red on and off
//void fragment() {
	//// Raises the red value from 0 to 1
	//// rate_of_flash is the speed of the flashing
	//COLOR.r = abs(tan(TIME * rate_of_flash));
//}
