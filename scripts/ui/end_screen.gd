extends Control

@onready var score_label: Label = $CenterContainer/HBoxContainer/Label2

func _on_button_pressed() -> void:
	SceneManager.restart_game()


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
