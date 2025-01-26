extends State

## Slime Follow State
#
# Handles the slime's following behavior
# Slime blorps directly towards its target until it gets within attack range
# Transitions to Attack when in attack range

@onready var nav_agent: NavigationAgent2D = $"../../NavigationAgent2D"

#var path_delay_timer : float = 0.1

# Called when transitioning into this state 
func enter()-> void:
	# Regenerate the nav path
	make_path()

# Called when transitioning out of this state
func exit() -> void:
	parent.movement = Vector2.ZERO

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	# If the delay timer is still counting
	#if path_delay_timer > 0:
		## Decrement it
		#path_delay_timer -= delta
		#
	## When the timer has expired
	#else:
		## Reset the timer and update the path
		#path_delay_timer = 3.0
		#make_path()
	
	# Update the path
	make_path()

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(_delta: float) -> void:
	# Calculates the directional vector based off the speed and the navigation
	# agent
	parent.movement = parent.speed * parent.global_position.direction_to(nav_agent.get_next_path_position())

# Called often to update the navigation path
func make_path() -> void:
	# Provides the navigation agent with the current position of the target
	nav_agent.target_position = parent.target.global_position

# Triggered when player within attack range
func on_target_reached() -> void:
	# Changes to the Attack state
	transitioned.emit(self, "attack")
