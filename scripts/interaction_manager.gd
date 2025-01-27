extends Node2D

## Interaction Manager Singleton
#
# Handles the acceptance of the Interact action and the presentation of the 
# interaction prompt
# Keeps track of which InteractionArea(s) the player is in contact with and 
# which one to display the prompt over, can also make prompt flash red if the
# player is denied that interact (e.g. locked door)

@onready var player: Entity = get_tree().get_first_node_in_group("player")
@onready var label: Label = $Label

const base_text = "[R] to\n"

var active_areas: Array = []
var can_interact: bool = true
#var requires_holding: bool = false

# Called by an InteractionArea node
func register_area(area: InteractionArea) -> void:
	# Add the given InteractionArea to active_areas
	active_areas.push_back(area)

# Called by an InteractionArea node
func unregister_area(area: InteractionArea) -> void:
	# Remove the given InteractionArea from active_areas if it is in active_areas
	active_areas.erase(area)

# Called every frame
func _process(_delta: float) -> void:
	# Checks if there are nodes in active_areas 
	# and an interaction isn't currently happening
	if active_areas.size() > 0 and can_interact:
		# Sorts active_areas so that the first node is the one closest to the player
		active_areas.sort_custom(_sort_by_distance_to_player)
		
		# Repositions the interaction prompt above the closest InteractionArea
		label.text = (active_areas[0].action_type_string + base_text + active_areas[0].action_name).to_upper()
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 44
		label.global_position.x -= active_areas[0].centering_correction
		
		# Makes the interaction prompt visible
		label.show()
		
		## Checks if the Interact action must be held
		#if active_areas[0].action_type == 0:
			#requires_holding = true
		## If the action doesn't have to be held
		#else:
			#requires_holding = false
	# If there aren't any nodes in active_areas or an interaction is happening
	else:
		# Makes the interaction prompt invisible
		label.hide()

# Called by sort_custom()
func _sort_by_distance_to_player(area1: InteractionArea, area2: InteractionArea) -> bool:
	# Given two Node2Ds, returns true if the first one is closer to the player than the second
	var area1_to_player: float = player.global_position.distance_to(area1.global_position)
	var area2_to_player: float = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

# Called every time an input occurs
func _input(event: InputEvent) -> void:
	#print(active_areas.size())
	# If Interact was pressed and an interaction isn't currently happening
	if event.is_action_pressed("interact") and can_interact:
		# If active_areas isn't empty
		if active_areas.size() > 0:
			# Indicate that an interaction is happening and hide the prompt
			can_interact = false
			label.hide()
			
			# Pause processing here until the interaction method of the current
			# InteractionArea is complete
			await active_areas[0].interact.call()
			
			# Indicate that the interaction is complete
			can_interact = true

# Called by an InteractionArea node
func failed_interact() -> void:
	# Make the interaction prompt RED
	label.modulate = Color("RED")
	
	# Create a timer that resets the color of the prompt when finished
	# Note: This is done using a lambda function as the Callable type argument for the
	# connect() method of the timer's timeout signal
	get_tree().create_timer(0.25).timeout.connect(
		func() -> void: label.modulate = Color(1, 1, 1)
		)


# Maelle was here
