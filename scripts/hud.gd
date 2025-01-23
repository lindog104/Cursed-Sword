extends Control

@onready var health_bar : TextureProgressBar = $MarginContainer/VBoxContainer/TextureProgressBar
@onready var soul_bar : TextureProgressBar = $MarginContainer/VBoxContainer/TextureProgressBar2

# Updates the health bar to reflect the current health
func on_update_health(current_health: int) -> void:
	 # Sets the amount of the under texture that is visible
	health_bar.value = current_health
