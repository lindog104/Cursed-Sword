extends Control

## Heads Up Display script
#
# Handles updates to the HUD in response to in-game actions

@onready var health_bar : TextureProgressBar = $MarginContainer/VBoxContainer/TextureProgressBar
@onready var soul_bar : TextureProgressBar = $MarginContainer/VBoxContainer/TextureProgressBar2

# Updates the health bar to reflect the current health
func update_health(current_health: int) -> void:
	 # Sets the amount of the under texture that is visible
	health_bar.value = current_health

# Updates the soul bar to reflect the current amount
func update_soul(current_soul: int) -> void:
	# Sets the amount of the under texture that is visible
	soul_bar.value = current_soul
