extends Enemy

## Slime class
#
# Handles the slime enemy behavior
# Has inherent knowledge of the player's location, only moves when on screen,
# attacks by bumping into the player, has movement cooldown

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

@export var initial_speed : float = 300.0
@export var movement_cooldown : float = 1.5

# Called every physics frame. 'delta' is the time between frames
func _physics_process(delta: float) -> void:
	
	# Moves towards the next spot on the generated path
	velocity = global_position.direction_to(nav_agent.get_next_path_position()) * speed
	
	# Enables movement
	move_and_slide()

# Generates a path leading to the target's position at the moment this is run
# Triggered when the PathTimer finishes
func make_path() -> void:
	# Updates the position vector that the pathfinder is aiming for
	nav_agent.target_position = target.global_position

# Triggered when the MovementTimer finishes
func on_movement_timer_timeout() -> void:
	# Halts the slime's movement for the duration of the cooldown timer
	speed = 0.0
	
	# Creates a single use timer that runs for the duration of the cooldown variable
	get_tree().create_timer(movement_cooldown).timeout.connect(on_movement_cooldown_timeout)

# Triggered when the cooldown timer finishes
func on_movement_cooldown_timeout() -> void:
	# Resumes the slime's movement for the duration of the MovementTimer
	speed = initial_speed
	
	# Starts the MovementTimer
	$MovementTimer.start()
