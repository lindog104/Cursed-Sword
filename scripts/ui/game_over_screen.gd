extends CanvasLayer

## Game Over Screen script
#
# Handles the buttons on the game over screen

# Triggered when the Restart button is pressed
func on_restart_pressed() -> void:
	SceneManager.restart_game()

# Triggered when the Quit button is pressed
func on_quit_pressed() -> void:
	# Change the current scene to the main menu scene
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
