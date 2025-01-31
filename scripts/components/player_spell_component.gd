extends SpellComponent

## Player Spell Component
#
# Handles the player inputs and feedback for spells

# Called when the scene enters the scene tree for the first time
func _ready() -> void:
	await owner.ready
	super()
	$ShieldSpell.parent_hurtbox = owner.host.get_node("HurtboxComponent")

# Called whenever input occurs
func _input(event: InputEvent) -> void:
	# If the SpellOne action was pressed
	if event.is_action_pressed("spell_one"):
		# Signal the SceneManager that SpellOne was inputted
		SceneManager.on_spell_attempt(0, spells[0].cooldown, spells[0].cost, cast_spell())
	# If the SpellTwo action was pressed
	#elif event.is_action_pressed("spell_two"):
		#pass
	## If the SpellThree action was pressed
	#elif event.is_action_pressed("spell_three"):
		#pass

# Called by SceneManager when a live host is possessed
func regain_energy(amount: int) -> void:
	# Increment energy by amount
	energy += amount
	
	# If energy greater than max
	if energy > max_energy:
		# Cut off the excess
		energy = max_energy
