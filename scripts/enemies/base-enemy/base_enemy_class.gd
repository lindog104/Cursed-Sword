extends Entity
class_name Enemy

## Base Enemy Class
#
# Parent class for all Enemy scenes
# Functions: 

@export var stun_threshhold: float = 0.25
@export var host_file: PackedScene
@export var target: Entity

# Called when the Player inputs to possess an enemy
func pass_possession_info() -> void:
	pass

# Triggered when damage is taken
func on_damage_taken(current_health: int) -> void:
	# If health reduced to zero
	if current_health <= 0:
		# Force transition to Die state
		$StateMachine.on_external_state_change("death")
	# If health above zero
	else:
		# Force transition to Stunned state
		$StateMachine.on_external_state_change("stunned")
