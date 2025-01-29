extends State
class_name StunnedState

## Base Stunned State
#
# Handles most enemies' hitstun behavior
# When health below 25%, slime can be possessed

@export var hurtbox : HurtboxComponent
@export var interaction_area : InteractionArea

var stun_timer : float = 1.0
var possession_timer : float = 5.0
var stunned_material : ShaderMaterial = load("res://shaders/stunned.tres")
var possessable_material : ShaderMaterial = load("res://shaders/possessable.tres")


# Called when transitioning into this state 
func enter()-> void:
	# Halt the parent's movement
	parent.movement = Vector2.ZERO
	
	# Check if health is below the threshhold
	if hurtbox.health < (hurtbox.max_health * parent.stun_threshhold):
		# Sets the parent's material to indicate possessability
		parent.material = possessable_material
		
		# Signals the interaction area to make itself active
		interaction_area.turn_on()
		interaction_area.action_name = "tempt"
		interaction_area.interact = temptation_attempt
		
		# Starts the possessability timer
		get_tree().create_timer(possession_timer).timeout.connect(on_stun_ended)
		
	# If health is above the threshhold
	else: 
		# Sets the parent's material to indicate stun
		parent.material = stunned_material
		
		# Start the stun timer
		get_tree().create_timer(stun_timer).timeout.connect(on_stun_ended)

# Called when transitioning out of this state
func exit() -> void:
	# Disable the interaction area
	interaction_area.turn_off()
	
	# Clear the parent's material
	parent.material = null

# Called when the Player Interacts with the InteractionArea
func temptation_attempt() -> void:
	# Signal the SceneManager to intiate the Temptation game
	# Pass along the enemy that signaled and
	# the Host that will be assigned to the player if successful
	SceneManager.play_temptation_minigame(parent, parent.host_file)

# Called when the stun or possessability timer expires
func on_stun_ended() -> void:
	# Transition to the Follow state
	transitioned.emit(self, "follow")
