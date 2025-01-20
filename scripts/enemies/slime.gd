extends Enemy

## Slime class
#
# Handles the slime enemy behavior
# Has inherent knowledge of the player's location, only moves when on screen,
# attacks by bumping into the player, has movement cooldown

func _physics_process(delta: float) -> void:
	
	move_and_slide()
