shader_type canvas_item;

uniform float rate_of_sway = 5.0;
uniform float strength_of_sway = 4.0;

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

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
