shader_type canvas_item;

// Called for every pixel in the frame
void fragment() {
	// Adds abitrary amounts of color to make the sword sprite whiter
	COLOR.rgb += vec3(0.4, 0.6, 0.8);
}
