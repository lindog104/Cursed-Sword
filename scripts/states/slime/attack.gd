extends State

## Slime Attack State
#
# Handles Slime Attack behavior
# Slime "aims, then jumps"
# Transitions to Follow if target is too far away

@onready var hitbox : HitboxComponent = $"../../HitboxComponent"

@export var initial_jump_speed : float = 1000.0
@export var initial_attack_time : float = 0.5
@export var attack_cooldown : float = 2.0

var jump_speed : float
var attack_time : float

# Called when transitioning into this state 
func enter()-> void:
	# Initializes the variables
	jump_speed = initial_jump_speed
	attack_time = initial_attack_time
	
	# Turns on the hitbox
	hitbox.turn_on()

# Called when transitioning out of this state
func exit() -> void:
	# Turns off the hitbox
	hitbox.turn_off()

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	pass

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(delta: float) -> void:
	
	if attack_time > 0:
		attack_time -= delta
		owner.velocity = (delta * jump_speed) * owner.target.global_position.normalized()
	elif attack_time <= 0 and jump_speed > 0:
		jump_speed = 0.0
		get_tree().create_timer(attack_cooldown).timeout.connect(on_cooldown_finished)

# Triggered when the cooldown timer finishes
func on_cooldown_finished() -> void:
	# Checks if the target is out of range
	if owner.global_position.distance_to(owner.target.global_position) > 50:
		# Changes to the Follow state
		transitioned.emit(self, "follow")
		
	# If the target is in range
	else:
		# Resets the variables
		attack_time = initial_attack_time
		jump_speed = initial_jump_speed
