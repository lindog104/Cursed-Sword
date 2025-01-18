extends CharacterBody2D

## Host control script
#
# Handles the player inputs for the host body

@export_range(0, 500, 10) var initial_speed : float = 300

var speed : float

# Called when the scene enters the scen tree for the first time
func _ready() -> void:
	# Assigns the player base speed
	speed = initial_speed

# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	
	# Sets the current velocity equal to directional vector that would 
	# move the player towards the mouse
	velocity = global_position.direction_to(get_global_mouse_position()) * speed
	
	# Tells the physics engine to move the node
	move_and_slide()

# Called every InputEvent. 'event' is the thing that the player did
func _input(event: InputEvent) -> void:
	# Checks if the player pressed the Halt action
	if event.is_action_pressed("halt"):
		# Sets host movement speed to zero
		speed = 0.0
	
	# Checks if the player released the Halt action
	if event.is_action_released("halt"):
		# Restores host movement speed to original
		speed = initial_speed
