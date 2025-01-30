extends Control

## Heads Up Display script
#
# Handles updates to the HUD in response to in-game actions

@onready var health_bar: TextureProgressBar = $MarginContainer/VBoxContainer/HealthBar
@onready var soul_bar: TextureProgressBar = $MarginContainer/VBoxContainer/SoulBar
@onready var key_counter: Label = $MarginContainer/HBoxContainer/KeyCounter
@onready var spell_icon: PanelContainer = $HBoxContainer2/SpellIcon
@onready var spell_icon_2: PanelContainer = $HBoxContainer2/SpellIcon2
@onready var spell_icon_3: PanelContainer = $HBoxContainer2/SpellIcon3

# Updates the health bar to reflect the current health
func update_health(current_health: int) -> void:
	 # Sets the amount of the under texture that is visible
	health_bar.value = current_health

# Updates the soul bar to reflect the current amount
func update_soul(spell_cost: int) -> void:
	# Sets the amount of the under texture that is visible
	soul_bar.value += spell_cost
