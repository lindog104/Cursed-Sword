extends Enemy
class_name Peasant

## State based Peasant class
#
# Handles the peasant enemy and creates the basis for the other human enemies

@export var front_sprite: CompressedTexture2D
@export var back_sprite: CompressedTexture2D

# Called every physics frame. 'delta' is the time between frames
func _physics_process(_delta: float) -> void:
	# Set velocity as a value of the movement vector and any knockback
	velocity = movement + knockback
	
	
	
	# Enable movement
	move_and_slide()

# Triggered by the Player entering the DetectionArea
func on_player_detected(body: Node2D) -> void:
	# Update the target reference
	target = body
	
	# Force state change to Follow
	$StateMachine.on_external_state_change("follow")

# Triggered by the Player leaving the DetectionArea
func on_player_lost(_body: Node2D) -> void:
	# Force state change to Wander
	$StateMachine.on_external_state_change("wander")
