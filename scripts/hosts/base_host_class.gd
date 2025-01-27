extends Node2D
class_name Host

## Base Host Class
#
# Parent class for all Host scenes
# Functions: move(), halt(), resume()

var initial_speed : float = 300.0
var speed : float

# Called when the scene enters the scene tree for the first time
func _ready() -> void:
	# Initializes the speed variable
	speed = initial_speed

# Handles the most basic type of Host movement
# Host moves endlessly towards the mouse
func move(player_position: Vector2) -> Vector2:
	# Create the movement vector variable
	var movement : Vector2
	
	# Calculates the directional vector that would move the player towards
	# the mouse at rate of the speed var
	movement = player_position.direction_to(get_global_mouse_position()) * speed
	
	# Checks if the Host is moving towards the right
	if movement.x > 0:
		# Flips the sprite to face the right
		$Icon.flip_h = true
	elif movement.x < 0:
		# Flips the sprite to face the left
		$Icon.flip_h = false
	
	# Return the movement vector to the player character
	return movement

# Handles the most basic version of the Host halting movement
# Host stops moving
func halt() -> void:
	# Clears the speed variable, effectively setting the directional vector to 0
	speed = 0.0

# Handles the most basic version of the Host resuming movement
# Host resumes moving at the same speed as before
func resume() -> void:
	# Resets speed to its original value
	speed = initial_speed

# Maelle was here
