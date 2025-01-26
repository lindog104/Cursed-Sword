extends Node2D

## Tempt minigame
#
# Handles the Tempt minigame
# The game is reset whenever the size of the Cursor over exceeds the Target
# or the player presses the Tempt action
# If the Tempt action is pressed while the difference in size between the 
# Target and the Cursor is less than the Tolerance, a point is awarded otherwise
# a point is detracted

signal minigame_finished

@onready var target: Sprite2D = $Target
@onready var cursor: Sprite2D = $Cursor
@onready var growth_timer: Timer = $GrowthTimer
@onready var success_label: Label = $CanvasLayer/Label

@export var growth_rate : float = 2.0
@export var excess_growth_time : float = 0.5
var cursor_tween : Tween
var success_count : int
var tolerance : float = 0.05
var player_won : bool

# Called whenever a key or input is pressed
func _input(event: InputEvent) -> void:
	# Checks is the Tempt action was pressed
	if event.is_action_pressed("tempt"):
		# Compares the size of the cursor to the size of the target
		var difference : Vector2 = abs(cursor.scale - target.scale)
		
		# If the difference is close enough
		if difference < Vector2(tolerance, tolerance):
			# Increment the successes
			success_count += 1
			
		# If the difference is too great
		else:
			# Decrement the successes
			success_count -= 1
		
		# Update the success label
		success_label.text = str(success_count)
		
		# Restart the minigame
		reset_minigame()

# Called by the Scene Manager
func play_minigame(speedup_modifier: float) -> bool:
	# Initialize the game result flag
	player_won = false
	
	# Accelerate the rate of gameplay using the modifier
	growth_rate /= speedup_modifier
	excess_growth_time /= speedup_modifier
	
	# Begin the minigame
	start_minigame()
	
	# Wait until the signal is emitted to execute any following code
	await minigame_finished
	
	# End the minigame
	end_minigame()
	
	# Returns the result of the minigame
	return player_won

# Called by the 
func start_minigame() -> void:
	# Make the minigame visible
	show()
	
	# Start the Tween
	build_tween()
	
	# Initialize and start the timer
	growth_timer.wait_time = growth_rate + excess_growth_time
	growth_timer.start()

# Called when the minigame is won or lost
func end_minigame() -> void:
	# Make the minigame invisible
	hide()
	
	# Stop the Tween
	cursor_tween.kill()
	
	# If the timer is not already stopped
	if !growth_timer.is_stopped():
		# Stop the timer
		growth_timer.stop()
	
	# Checks if the player won the minigame
	#if :
		# Updates the game result flag
		#player_won = true
	
	# Signal the completion of the game
	minigame_finished.emit()

# Called when the minigame is to be reset
func reset_minigame() -> void:
	# Stop the Tween
	cursor_tween.kill()
	
	# If the timer is not already stopped
	if !growth_timer.is_stopped():
		# Stop the timer
		growth_timer.stop()
	
	# Checks if the score has reached the upper limit
	
	# Checks if the score has reached the lower limit
	
	# Reset the cursor size
	cursor.scale = Vector2.ONE
	
	# Reset the Tween and the timer
	build_tween()
	growth_timer.start()

# Called in _ready and when the game is reset
func build_tween() -> void:
	# Initialize the tween
	cursor_tween = get_tree().create_tween()
	
	# Assign it to increase the size of the cursor
	cursor_tween.tween_property(cursor, "scale", Vector2(2.5,2.5), (growth_rate + excess_growth_time))

# Called when the Growth Timer expires
func on_growth_timeout() -> void:
	# Decrement the success count
	success_count -= 1
	
	# Update the success label
	success_label.text = str(success_count)
	
	# Reset the minigame
	reset_minigame()
