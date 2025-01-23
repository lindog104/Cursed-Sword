extends Node
class_name KnockbackComponent

## Knockback Component Class
#
# Handles accepting knockback from hitboxes and moving the parent scene

var knockback : Vector2
var knockback_tween : Tween

# Called by the Hurtbox when knockback received
# Accepts a direction vector, a strength modifier, and a max time as parameters
# The direction vector is required
func get_knocked_back(kb_direction: Vector2, kb_modifier: float = 4.0, stop_time: float = 0.25) -> void:
	# Calculates the knockback magnitude as defaultly 4 times the parent's current velocity
	var kb: float = abs(owner.velocity.x) * kb_modifier
	
	# Establishes the minimum amount of knockback using the parent's base speed
	kb = maxf(kb, (owner.speed / 2.5) * kb_modifier)
	
	# Initializes the directional knockback vector
	knockback = Vector2(kb, kb) * kb_direction
	
	# Disables the current tween if one is active
	if knockback_tween:
		knockback_tween.kill()
	
	# Creates a new tween to interpolate the knockback vector towards 0
	# The knockback vector will reach 0 after stop_time seconds
	knockback_tween = get_tree().create_tween()
	knockback_tween.tween_property(self, "knockback", Vector2(0,0), stop_time)

# Called every physics frame. 'delta' is the time between frames
func _physics_process(_delta: float) -> void:
	# Applies the knockback if there is any
	owner.velocity += knockback
