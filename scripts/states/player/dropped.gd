extends State

## Player Dropped State
# 
# Handles the Player behavior when the Host has died/Player health depleted
# Player cannot move, attack, or use spells
# Player enters an increased difficulty Tempt game

# Called when transitioning into this state 
func enter()-> void:
	pass

# Called when transitioning out of this state
func exit() -> void:
	pass

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	pass

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(_delta: float) -> void:
	pass
