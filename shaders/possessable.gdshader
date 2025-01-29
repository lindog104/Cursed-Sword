shader_type canvas_item;

uniform float rate_of_sway = 5.0;
uniform float strength_of_sway = 3.0;
uniform float rate_of_flash = 4.0;

// Called for every vertex in the image
void vertex() {
	// If the vertex is above the centerline of the image
	if (VERTEX.y < 0.0) {
		// Move that vertex left and right
		// strength_of_sway is the size of the movement
		// rate_of_sway is the speed of the movement
		VERTEX.x += sin(TIME * rate_of_sway) * strength_of_sway;
	}
}

// Called for every pixel the material is visible on.
// Makes the image flash white on and off
void fragment() {
	// Measures the total amount of color in the pixel
	float mask = length(COLOR.rgb);

	// Levels out the rgb of each pixel
	// rate_of_flash is the speed of the flashing
	COLOR.rgb += vec3(mask) * abs(sin(TIME * rate_of_flash));

	// Checks if the pixel is not transparent
	if (COLOR.a > 0.0) {
		// Makes the pixel's slightly transparent
		// rate_of_flash is the speed of the flashing
		COLOR.a = abs(tan(TIME * rate_of_flash)) + 0.2;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
