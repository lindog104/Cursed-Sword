shader_type canvas_item;

void vertex() {
	VERTEX -= vec2(tan(TIME));
}

//void fragment() {
	//if (COLOR.a > 0.0) {
		//COLOR.a = 0.3;
		//COLOR.r += 1.0;
	//}
//}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
