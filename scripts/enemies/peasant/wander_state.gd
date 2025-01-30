extends State

## Peasant Wander State
#
# Handles the Peasant's idle behavior
# Generates a random directional vector and moves that way for a random
# amount of time

var move_direction: Vector2
var wander_time: float

# Called when transitioning into this state 
func enter()-> void:
	# Generate the direction to wander in and for how long
	randomize_wander()

# Called when transitioning out of this state
func exit() -> void:
	pass

# Called every frame. 'delta' is the time between frames
func update(delta: float) -> void:
	# If wander_time is unexpired
	if wander_time > 0:
		# Decrement it 
		wander_time -= delta
	# If wander_time is expired
	else:
		# Generate a new direction and time to wander in
		randomize_wander()

# Called every physics frame. 'delta' is the time between frames
func physicsUpdate(_delta: float) -> void:
	# Move the parent
	parent.movement = parent.speed * move_direction

# Called when entering this state and when wander_time expires
func randomize_wander() -> void:
	# Generate a random normalized vector between -1 and 1
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
	# Generate a random float between 1 and 3
	wander_time = randf_range(1, 3)
