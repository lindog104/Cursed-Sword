extends State

## Player Held State
#
# Handles the player behavior when the Sword has a Host
# Player moves in the direction the mouse is pointing unless Halt is pressed
# Player can attack and use spells

@export var host : Host

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
