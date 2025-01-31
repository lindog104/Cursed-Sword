extends State

## Slime Attack State
#
# Handles Slime Attack behavior
# Slime "aims, then jumps"
# Transitions to Follow if target is too far away

@export var hitbox : HitboxComponent
@export var initial_jump_speed : float = 80.0
@export var initial_attack_time : float = 0.4
@export var attack_cooldown : float = 2.0

var jump_speed : float = 0.0
var attack_time : float = 0.0
var attack_direction : Vector2
var attacking_material: ShaderMaterial = load("res://shaders/attacking.tres")

# Called when transitioning into this state 
func enter()-> void:
	# Make an attack
	signal_attack()

# Called when transitioning out of this state
func exit() -> void:
	print("Attack Exited")
	# Reset the parent's movement
	parent.set_deferred("movement", Vector2.ZERO)
	
	# Turns off the hitbox and clears the attack variables
	hitbox.turn_off()
	attack_time = 0.0
	jump_speed = 0.0
	
	# Resets the parent's material
	parent.material = null
	
	# Stop the timers
	$StartUp.stop()
	$Cooldown.stop()

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(delta: float) -> void:
	# While the attack timer is counting
	if attack_time > 0:
		# Decrement the timer using delta
		attack_time -= delta
		
		# Calculates the directional vector using the parent's position,
		# the target's position and the jump speed
		attack_direction = parent.global_position.direction_to(
			parent.target.global_position)
		parent.movement = jump_speed * attack_direction
		
	# If the attack timer has expired and the jump speed hasn't been cleared yet
	elif attack_time <= 0 and jump_speed > 0:
		# Clear the jump speed, stop movement, and turn off the hitbox
		jump_speed = 0.0
		parent.movement = Vector2.ZERO
		hitbox.turn_off()
		
		# Create a single use timer to handle the attack cooldown time
		$Cooldown.start()

# Called internally to signal attack just before attacking
func signal_attack() -> void:
	# Loads the attacking shader to warn the player of the attack
	parent.material = attacking_material
	
	# Plays the attacking animation
	parent.sprite.play("jump")
	
	# Turns on the hitbox
	hitbox.turn_on()
	
	# Creates an initial cooldown before the first attack at half attack cooldown
	$StartUp.start()

# Called internally to begin attack
func begin_attack() -> void:	
	# Resets the parent's material
	parent.material = null
	
	# Resets the variables
	attack_time = initial_attack_time
	jump_speed = initial_jump_speed

# Triggered when the cooldown timer finishes
func on_cooldown_finished() -> void:
	# Checks if the target is out of range
	if parent.global_position.distance_to(parent.target.global_position) > 50:
		# Changes to the Follow state
		transitioned.emit(self, "follow")
		
	# If the target is in range
	else:
		# Make another attack
		signal_attack()

# Triggered when Hitbox contacts something
func on_hit_detected(_area: Area2D) -> void:
	# Knockback the parent in the opposite direction
	parent.get_knocked_back(-1 * attack_direction)
	
	# End the attack
	attack_time = 0.0
