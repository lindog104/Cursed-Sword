extends Enemy

## State based Slime class
#
# Handles the slime enemy behavior using a State Machine
# Has inherent knowledge of the player's location, only moves when on screen,
# attacks by bumping into the player, has movement cooldown

@onready var interaction_area: InteractionArea = $InteractionArea

@export var initial_speed : float = 20.0

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
