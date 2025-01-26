extends Node

## Scene Manager Script
#
# Handles the transitions and interactions between different children in
# the game scene

@export var tempt_game : Node2D

var percent_of_slowdown : float = 0.5

# Triggered by the player entering the Dropped state
# Or the InteractionManager signaling a possession input
func play_temptation_minigame(dropped: bool = false) -> void:
	var speedup_modifier : float = 1 / percent_of_slowdown
	
	Engine.time_scale = percent_of_slowdown
	
	tempt_game.start_minigame()
	
