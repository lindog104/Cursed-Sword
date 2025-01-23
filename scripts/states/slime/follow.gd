extends State

## Slime Follow State
#
# Handles the slime's following behavior
# Slime blorps directly towards its target until it gets within attack range
# Transitions to Attack when in attack range

@onready var timer : Timer = $Timer
@onready var nav_agent: NavigationAgent2D = $"../../NavigationAgent2D"

var path_delay_timer : float = 3.0

# Called when transitioning into this state 
func enter()-> void:
	pass

# Called when transitioning out of this state
func exit() -> void:
	pass

# Called every frame. 'delta' is the time between frames
func update(delta: float) -> void:
	# If the delay timer is still counting
	if path_delay_timer > 0:
		# Decrement it
		path_delay_timer -= delta
		
	# When the timer has expired
	else:
		# Reset the timer and update the path
		path_delay_timer = 3.0
		make_path()

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(delta: float) -> void:
	# Calculates the directional vector based off the speed and the navigation
	# agent
	owner.velocity = (delta * owner.speed) * nav_agent.get_next_path_position()

# Regenerates navigation path
func make_path() -> void:
	# Provides the navigation agent with the current position of the target
	nav_agent.target_position = owner.target.global_position

# Triggered when player within attack range
func on_target_reached() -> void:
	# Changes to the Attack state
	transitioned.emit(self, "attack")
