extends DeathState

## Slime Death State
#
# Handles the slime falling to or below zero health
# Plays death animation then deletes body

# Called when transitioning into this state
func enter() -> void:
	#print("death entered")
	# Play the death animation
	parent.sprite.play("die")
	
	# Connect the animation_finished signal
	parent.sprite.animation_finished.connect(delete_parent)

# Triggered by the animation_finished signal
func delete_parent() -> void:
	# Delete the parent scene
	parent.queue_free()
