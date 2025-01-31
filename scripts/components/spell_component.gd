extends Node2D
class_name SpellComponent

## Spell Component Class
#
# Handles soul energy consumption and spell calls

@onready var energy: int = max_energy

@export var max_energy: int = 100
@export var regen: bool = false

var spells: Array = []

# Called when the scene enters the scene tree for the first time
func _ready() -> void:
	# Cycle through each child of this node
	for child in get_children():
		# If the child is of the Spell class
		if child is Spell:
			# Add it to the spells array
			spells.append(child)

# Called every frame. 'delta' is the time between frames
func _process(_delta: float) -> void:
	# If the parent has regenerating soul energy
	if regen:
		# If energy is less than max
		if energy < max_energy:
			# Increment energy maybe
			energy += randi_range(0, 1)

# Called by the parent to cast a random spell
func cast_spell() -> bool:
	var failed_cast: bool = true
	
	# Choose a spell at random
	var selected_spell: Spell = spells.pick_random()
	
	# If the spell can be cast
	if energy >= selected_spell.cost and selected_spell.can_be_cast:
		# Cast the spell and deduct the cost
		selected_spell.cast()
		energy -= selected_spell.cost
		
		# Indicate that the spell was cast successfully
		failed_cast = false
	
	# Return if the spell was cast
	return failed_cast
