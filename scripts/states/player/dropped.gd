extends State

## Player Dropped State
# 
# Handles the Player behavior when the Host has died/Player health depleted
# Player cannot move, attack, or use spells
# Player enters an increased difficulty Tempt game

# Called when transitioning into this state 
func enter()-> void:
	# Signal SceneManager that Player is dead
	SceneManager.on_player_death()
	
	## Above is temp code, below is where the final code goes
	## Entering this state will disable the sword and target the nearest 
	## intelligent host to as the temptation target
	## This is not here yet because the intelligent enemies don't exist yet
	

# Called when transitioning out of this state
func exit() -> void:
	# Enable Player control over the sword
	parent.enable_sword()

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	pass

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(_delta: float) -> void:
	pass
