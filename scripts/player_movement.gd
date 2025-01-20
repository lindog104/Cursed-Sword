extends CharacterBody2D

## Player character control script
#
# Handles the movement of the player character whether they have a Host or not

@export var host : Host

# Called every physics frame. 'delta' is the time between frames
func _physics_process(_delta: float) -> void:
	
	# If the player is currently possessing a Host
	if host:
		# Call the Host's move function to the determine the movement vector
		velocity = host.move(global_position)
	
	# Enable movement
	move_and_slide()

# Called whenever a key or input is pressed
func _input(event: InputEvent) -> void:
	# If the Halt action was pressed
	if event.is_action_pressed("halt"):
		# If the player has a Host
		if host:
			# Call the Host's halt function to stop movement
			host.halt()
	
	# If the Halt action was released
	if event.is_action_released("halt"):
		# If the player has a Host
		if host:
			# Call the Host's resume function to resume movement
			host.resume()
