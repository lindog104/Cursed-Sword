extends State
class_name FollowState

## Base Enemy Follow State
#
# Handles most enemies' following behavior
# Enemy moves directly towards its target until it gets within attack range
# Transitions to Attack when in attack range

@export var nav_agent: NavigationAgent2D

# Called when transitioning into this state 
func enter()-> void:
	# Regenerate the nav path
	make_path()

# Called when transitioning out of this state
func exit() -> void:
	# Reset the parent's movement
	parent.set_deferred("movement", Vector2.ZERO)

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	# Update the path
	make_path()

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(_delta: float) -> void:
	# Calculates the directional vector based off the speed 
	# and the navigation agent
	parent.movement = parent.speed * parent.global_position.direction_to(
		nav_agent.get_next_path_position())

# Called often to update the navigation path
func make_path() -> void:
	# Provides the navigation agent with the current position of the target
	nav_agent.target_position = parent.target.global_position

# Triggered when player within attack range
func on_target_reached() -> void:
	# Changes to the Attack state
	transitioned.emit(self, "attack")
