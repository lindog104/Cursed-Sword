extends Entity

## Player character control script
#
# Handles the movement of the player character whether they have a Host or not

@onready var pivot: Node2D = $Pivot
@onready var spell_component: Node2D = $SpellComponent

@export var host : Host

# Called by the Hurtbox when damage taken
func on_damage_taken(current_health: int) -> void:
	# Signal the SceneManager that health was changed
	SceneManager.on_health_changed(current_health)
	
	# If Host body is dead
	if current_health <= 0:
		# Transition to the Dropped state
		$StateMachine.on_external_state_change("dropped")
		
		# Remove the current Host scene
		host.queue_free()

# Called by the SceneManager when Host reference is changed
func change_host(new_host: Host) -> void:
	# Update the internal reference and the Held state's reference
	host = new_host
	$StateMachine/Held.host = new_host

# Called by the Held state when it is exited
func disable_sword() -> void:
	# Disable _process() and _input()
	pivot.set_process(false)
	pivot.set_process_input(false)
	
	# Update the flag
	pivot.held = false

# Called by the Dropped or Thrown state when it is exited
func enable_sword() -> void:
	# Enable _process() and _input()
	pivot.set_process(true)
	pivot.set_process_input(true)
	
	# Update the flag
	pivot.held = true
