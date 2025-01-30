extends Node2D
class_name Spell

## Base Spell Class
#
# Establishes the Spell class of Objects
# Each spell has a cooldown, a cost, and an effect

@export var cost: int = 10
@export var cooldown: int = 3

var can_be_cast: bool = true

# Called by the SpellComponent parent
func cast() -> void:
	# Here is where the effect of the spell would go
	pass
