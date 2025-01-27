extends Node

## Scene Manager Script
#
# Handles the transitions and interactions between different children in
# the game scene

@onready var tempt_game: CanvasLayer = load("res://scenes/tempt_game.tscn").instantiate()

var percent_of_slowdown : float = 0.5

# Triggered by the player entering the Dropped state
# Or the InteractionManager signaling a possession input
func play_temptation_minigame(dropped: bool = false) -> void:
	# If the current scene does not already have the Temptation game as a child
	if !get_tree().current_scene.has_node("TemptGame"):
		# Add it
		get_tree().current_scene.add_child(tempt_game)
	
	# Initialize a reference to the current scene's Temptation game child
	var temptation_game: CanvasLayer = get_tree().current_scene.get_node("TemptGame")
	
	# Initialize the acceleration factor that is applied to the minigame
	# to make it appear as normal time
	var speedup_modifier : float = 1 / percent_of_slowdown
	
	# Slow down the game
	Engine.time_scale = percent_of_slowdown
	
	# Call the minigame and store its result
	var minigame_result = temptation_game.play_minigame(speedup_modifier)
	
