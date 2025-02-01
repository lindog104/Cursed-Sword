extends Enemy
class_name Peasant

## State based Peasant class
#
# Handles the peasant enemy and creates the basis for the other human enemies

@onready var sprite: Sprite2D = $Sprite2D

@export var front_sprite: CompressedTexture2D
@export var back_sprite: CompressedTexture2D

enum Orientation{LEFT, RIGHT, UP, DOWN}

var facing: int = Orientation.LEFT

# Called every physics frame. 'delta' is the time between frames
func _physics_process(_delta: float) -> void:
	# Set velocity as a value of the movement vector and any knockback
	velocity = movement + knockback
	
	# If moving to the right
	if velocity.x > 0:
		# Flip sprite to face right
		sprite.flip_h = true
		
	# If moving to the left
	elif velocity.x < 0:
		# Reset sprite to face left
		sprite.flip_h = false
	
	# If moving down
	if velocity.y > 0:
		# Reset sprite to face forward
		sprite.texture = front_sprite
		
	# If moving up
	elif velocity.y < 0:
		# Change sprite to face away
		sprite.texture = back_sprite
	
	# Update facing
	setOrientation()
	
	# Enable movement
	move_and_slide()

# Triggered by the Player entering the DetectionArea
func on_player_detected(body: Node2D) -> void:
	# Update the target reference
	target = body
	print("Peasant set target to ", target)
	
	# Force state change to Follow
	$StateMachine.on_external_state_change("follow")

# Triggered by the Player leaving the DetectionArea
func on_player_lost(_body: Node2D) -> void:
	# Force state change to Wander
	$StateMachine.on_external_state_change("wander")

# Updates the facing variable to represent the direction to attack in
func setOrientation() -> void:
	# Checks if lateral movement is greater than vertical movement
	if abs(velocity.x) > abs(velocity.y):
		
		# If lateral movement component is positive, direction of movement is to the RIGHT
		if velocity.x > 0:
			facing = Orientation.RIGHT
			
		# else direction of movement is to the LEFT
		else:
			facing = Orientation.LEFT
	# clse vertical movement is greater than lateral
	else:
		# If vertical movement component is positive, direction of movement is DOWN
		if velocity.y > 0:
			facing = Orientation.DOWN
			
		# else direction of movement is UP
		else:
			facing = Orientation.UP
