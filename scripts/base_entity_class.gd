extends CharacterBody2D
class_name Entity

## Base Entity Class
#
# Base parent class for all things that can move, have health and/or be knocked back

@export var speed : float = 300.0

var movement : Vector2 

var knockback : Vector2
var knockback_tween : Tween

# Called by the Hurtbox when knockback received
# Accepts a direction vector, a strength modifier, and a max time as parameters
# The direction vector is required
func get_knocked_back(kb_direction: Vector2, kb_modifier: float = 4.0, stop_time: float = 0.25) -> void:
	# Calculates the knockback magnitude as defaultly 4 times the parent's current velocity
	var kb: float = abs(velocity.x) * kb_modifier
	
	# Establishes the minimum amount of knockback using the parent's base speed
	# If the parent's speed is less than 300, it uses that instead
	kb = maxf(kb, (maxf(300.0,speed) / 2.5) * kb_modifier)
	
	# Initializes the directional knockback vector
	knockback = Vector2(kb, kb) * kb_direction.normalized()
	
	# Disables the current tween if one is active
	if knockback_tween:
		knockback_tween.kill()
	
	# Creates a new tween to interpolate the knockback vector towards 0
	# The knockback vector will reach 0 after stop_time seconds
	knockback_tween = get_tree().create_tween()
	knockback_tween.tween_property(self, "knockback", Vector2(0,0), stop_time)
	
