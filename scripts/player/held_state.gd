extends State

## Player Held State
#
# Handles the player behavior when the Sword has a Host
# Player moves in the direction the mouse is pointing unless Halt is pressed
# Player can attack and use spells

@export var host : Host

# Called when transitioning into this state 
func enter()-> void:
	# If the host reference is empty or does not match the player's current host
	if !host or parent.host != host:
		# Update the host reference
		host = parent.host

# Called when transitioning out of this state
func exit() -> void:
	# Disable Player control over the sword
	parent.disable_sword()
	
	# Clear the player's movement
	parent.movement = Vector2.ZERO

# Called every frame. 'delta' is the time between frames
func update(_delta: float) -> void:
	pass

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(_delta: float) -> void:
	# Call the Host's move function to determine the movement vector
	parent.movement = host.move(parent.global_position)

# Called whenever a key or input is pressed
func _input(event: InputEvent) -> void:
	# If the Halt action was pressed
	if event.is_action_pressed("halt"):
		# Call the Host's halt function to stop movement
		host.halt()
	
	# If the Halt action was released
	if event.is_action_released("halt"):
		# Call the Host's resume function to resume movement
		host.resume()
