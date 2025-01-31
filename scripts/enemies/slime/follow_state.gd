extends FollowState

## Slime Follow State
#
# Handles the slime's following behavior
# Slime blorps directly towards its target until it gets within attack range
# Transitions to Attack when in attack range

# Called when transitioning into this state 
func enter()-> void:
	# Regenerate the nav path
	make_path()
	
	# Waits from the parent to finish its _ready call
	await parent.ready
	
	# Play the walking animation
	parent.sprite.play("walk")
