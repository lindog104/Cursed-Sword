extends State

## Slime Idle state
#
# Handles the idle behavior for the Slime enemy
# Slime wanders aimlessly, avoiding walls
# Transitions to Follow when Slime visible on screen

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
