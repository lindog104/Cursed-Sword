extends State

## Player Thrown State
#
# Handles the Player behavior when the Sword is thrown
# Locks out player movement, attacks, and spells
# If an enemy is struck before the Sword falls, transition to Held
# Else, transition to Dropped

# Called when transitioning into this state 
func enter()-> void:
	pass

# Called when transitioning out of this state
func exit() -> void:
	# Enable Player control over the Sword
	parent.enable_sword()

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	pass

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(_delta: float) -> void:
	pass
