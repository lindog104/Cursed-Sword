extends State

## Peasant Attack State
#
# Handles the Peasant attack behavior
# Determines the direction to attack in (LEFT, RIGHT, UP, DOWN)
# Plays the appropriate animation

@export var anim_player: AnimationPlayer

# Called when transitioning into this state 
func enter()-> void:
	# Make an attack
	make_attack()

# Called when transitioning out of this state
func exit() -> void:
	# Stop the timer
	$Cooldown.stop()

# Called when entering this state and after cooldown expires
func make_attack() -> void:
	# Checks if the target is out of range
	if parent.global_position.distance_to(parent.target.global_position) > 20:
		# Changes to the Follow state
		transitioned.emit(self, "follow")
	
	# Determine the direction that the parent is facing in
	match parent.facing:
		0:
			# Attack generally to the left
			anim_player.play("sword_animations/swing_left")
		1:
			# Attack generally to the right
			anim_player.play("sword_animations/swing_right")
		2:
			# Attack generally above
			anim_player.play("sword_animations/swing_up")
		3:
			# Attack generally down
			anim_player.play("sword_animations/swing_down")
	
	# Start the cooldown timer
	$Cooldown.start()
