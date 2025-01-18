extends Node2D

## Sword control script
# 
# Handles the control of the sword by the player's mouse position


# Called every frame. 'delta' is the time between frames
func _process(_delta: float) -> void:
	# Rotates the node to point towards the provided vector
	look_at(get_global_mouse_position())
