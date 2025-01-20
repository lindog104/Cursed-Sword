shader_type canvas_item;

// This function runs for every pixel in the texture
void fragment() {
	// If that pixel is not black
	if (COLOR.rgb != vec3(0.0, 0.0, 0.0) ) {
		// Change that color to blue
		COLOR.rgb = vec3(0.0, 0.0, 1.0);
	}
}

