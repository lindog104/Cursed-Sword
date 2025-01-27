extends Enemy

## State Slime class
#
# Handles the slime enemy behavior using a State Machine
# Has inherent knowledge of the player's location, only moves when on screen,
# attacks by bumping into the player, has movement cooldown

@onready var interaction_area: InteractionArea = $InteractionArea

@export var target : CharacterBody2D
@export var initial_speed : float = 300.0

# Called every physics frame. 'delta' is the time between frames
func _physics_process(_delta: float) -> void:
	
	# Set velocity as a value of the movement vector and any knockback
	velocity = movement + knockback
	
	# Enables movement
	move_and_slide()

# Triggered when damage is taken
func on_damage_taken(current_health: int) -> void:
	# If health reduced to zero
	if current_health <= 0:
		# Force transition to Die state
		$StateMachine.on_external_state_change("die")
	# If health above zero
	else:
		# Force transition to Stunned state
		$StateMachine.on_external_state_change("stunned")
