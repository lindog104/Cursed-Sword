extends Enemy

## State based Slime class
#
# Handles the slime enemy behavior using a State Machine
# Has inherent knowledge of the player's location, only moves when on screen,
# attacks by bumping into the player, has movement cooldown

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var initial_speed : float = 20.0

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
	
	## If moving down
	#if velocity.y > 0:
		## Reset sprite to face forward
		#sprite.texture = front_sprite
		#
	## If moving up
	#elif velocity.y < 0:
		## Change sprite to face away
		#sprite.texture = back_sprite
	
	# Enable movement
	move_and_slide()

# Triggered by the AnimatedSprite finishing an animation
func on_animation_finished() -> void:
	# Play the idle animation
	sprite.play("idle")

# Triggered when damage is taken
func on_damage_taken(current_health: int) -> void:
	# Play the hurt animation
	sprite.play("hurt")
	
	# If health reduced to zero
	if current_health <= 0:
		# Disconnect the animation_finished signal
		sprite.animation_finished.disconnect(on_animation_finished)
		
		# Force transition to Die state
		$StateMachine.on_external_state_change("death")
	# If health above zero
	else:
		# Force transition to Stunned state
		$StateMachine.on_external_state_change("stunned")
