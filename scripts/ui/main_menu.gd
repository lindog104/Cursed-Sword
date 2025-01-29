extends Control

## Main Menu Screen script
#
# Handles the buttons on the main menu

# Triggered when the Play button is pressed
func on_play_pressed() -> void:
	# Change the current scene to the inventory select screen
	# Currently goes to the testground
	get_tree().change_scene_to_file("res://scenes/levels/testground.tscn")

# Triggered when the Tutorial button is pressed
func on_tutorial_pressed() -> void:
	# Make visible a new window containing a series of tutorial animations that 
	# explain possession, temptation, spells, and items
	pass # Replace with function body.
