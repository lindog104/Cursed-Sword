extends Enemy

## State Slime class
#
# Handles the slime enemy behavior using a State Machine
# Has inherent knowledge of the player's location, only moves when on screen,
# attacks by bumping into the player, has movement cooldown

@onready var hurtbox : HurtboxComponent = $HurtboxComponent

@export var target : CharacterBody2D
@export var initial_speed : float = 300.0

var speed : float 

# Called every physics frame. 'delta' is the time between frames
func _physics_process(_delta: float) -> void:
	
	# Enables movement
	move_and_slide()

# Triggered when damage is taken
func on_damage_taken() -> void:
	# If health reduced to zero
	if hurtbox.health == 0:
		# Force transition to Die state
		$StateMachine.on_external_state_change("die")
	# If health above zero
	else:
		$StateMachine.on_external_state_change("stunned")
