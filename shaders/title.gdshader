shader_type canvas_item;

//uniform float strength_of_sway = 20.0;

// Called for every vertex the material is visible on.
void vertex() {
	//if (VERTEX.y < 100.0) {
		//VERTEX.x += sin(TIME * 10.0) * strength_of_sway;
	//} 
	//else {
		//VERTEX.x += sin(-TIME) * strength_of_sway;
	//}
}

// Called for every pixel the material is visible on.
void fragment() {
	//COLOR.rgb += vec3(0.1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
