extends Entity
class_name Enemy

## Base Enemy Class
#
# Parent class for all Enemy scenes
# Functions: 

@export var stun_threshhold : float = 0.25

# Called when the Player inputs to possess an enemy
func pass_possession_info() -> void:
	pass
