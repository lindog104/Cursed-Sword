extends State

## Slime Death State
#
# Handles the slime falling to or below zero health
# Enables possession interaction area

@export var despawn_timer : float = 30.0

# Called when transitioning into this state 
func enter()-> void:
	# Halt the parent's movement
	parent.movement = Vector2.ZERO
	
	# Enable the interaction area
	##Code needed here once interaction area's have been implemented
	
	# Start the despawn timer
	get_tree().create_timer(despawn_timer).timeout.connect(on_despawn_ended)         

# Called when transitioning out of this state
func exit() -> void:
	pass

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	pass

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(_delta: float) -> void:
	pass

# Called when the despawn timer expires
func on_despawn_ended() -> void:
	# Delete the parent scene
	parent.queue_free()
