extends State

## Slime Death State
#
# Handles the slime falling to or below zero health
# Enables possession interaction area

@export var despawn_time: float = 30.0
@export var interaction_area: InteractionArea

# Called when transitioning into this state 
func enter()-> void:
	# Halt the parent's movement
	parent.movement = Vector2.ZERO
	
	# Enable the interaction area
	interaction_area.turn_on()
	interaction_area.action_name = "possess"
	interaction_area.interact = become_possessed
	
	# Start the despawn timer
	get_tree().create_timer(despawn_time).timeout.connect(on_despawn_ended)         

# Called when transitioning out of this state
func exit() -> void:
	# Disable the interaction area
	interaction_area.turn_off()

# Called when the Player interacts with the InteractionArea
func become_possessed() -> void:
	# Signal the SceneManager to have the player possess this corpse
	# Pass along the enemy that signaled and
	# the Host that will be assigned to the player
	SceneManager.pass_new_host(parent, parent.host_file)

# Called when the despawn timer expires
func on_despawn_ended() -> void:
	# Delete the parent scene
	parent.queue_free()
