extends State

## Slime Attack State
#
# Handles Slime Attack behavior
# Slime "aims, then jumps"
# Transitions to Follow if target is too far away

@export var hitbox : HitboxComponent
@export var initial_jump_speed : float = 800.0
@export var initial_attack_time : float = 0.05
@export var attack_cooldown : float = 2.0

var jump_speed : float = 0.0
var attack_time : float = 0.0
var attack_direction : Vector2

# Called when transitioning into this state 
func enter()-> void:
	# Creates an initial cooldown before the first attack at half attack cooldown
	get_tree().create_timer(attack_cooldown).timeout.connect(on_cooldown_finished)
	
	# Turns on the hitbox
	hitbox.turn_on()

# Called when transitioning out of this state
func exit() -> void:
	# Turns off the hitbox
	hitbox.turn_off()
	
	# Resets the parent's material
	parent.material = null

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	pass

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(delta: float) -> void:
	# While the attack timer is counting
	if attack_time > 0:
		# Decrement the timer using delta
		attack_time -= delta
		
		# Calculates the directional vector using the parent's position, the target's position
		# and the jump speed
		attack_direction = parent.global_position.direction_to(parent.target.global_position)
		parent.movement = jump_speed * attack_direction
		
	# If the attack timer has expired and the jump speed hasn't been cleared yet
	elif attack_time <= 0 and jump_speed > 0:
		# Clear the jump speed to stop movement
		jump_speed = 0.0
		
		# Clear the attacking shader
		parent.material = null
		
		# Create a single use timer to handle the attack cooldown time
		get_tree().create_timer(attack_cooldown).timeout.connect(on_cooldown_finished)

# Triggered when the cooldown timer finishes
func on_cooldown_finished() -> void:
	# Checks if the target is out of range
	if parent.global_position.distance_to(parent.target.global_position) > 100:
		# Changes to the Follow state
		transitioned.emit(self, "follow")
		
	# If the target is in range
	else:
		# Loads the attacking shader to warn the player of the attack
		parent.material = load("res://shaders/attacking.tres")
		
		# Resets the variables
		attack_time = initial_attack_time
		jump_speed = initial_jump_speed

# Triggered when Hitbox contacts something
func on_hit_detected(_area: Area2D) -> void:
	# Knockback the parent in the opposite direction
	parent.get_knocked_back(-1 * attack_direction)
	
	# End the attack
	attack_time = 0.0
	
