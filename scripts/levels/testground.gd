extends Node2D

## Testground manager script
#
# Handles an assignments or value changes that need to occur whenever the scene
# is loaded or reloaded

# Called when the scene enters the scene tree for the first time
func _ready() -> void:
	# Assign the Player reference to the Autoloads
	SceneManager.player = $Player
	InteractionManager.player = $Player
