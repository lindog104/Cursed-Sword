extends Spell

## Shield Spell Class
#
# Handles the casting of the shield spell
# Envelopes its user for a limited duration, deflects one hit
# High cost, high cooldown

@export var parent_hurtbox: HurtboxComponent

var second_can_be_cast: bool = true

# Called by the SpellComponent parent
func cast() -> void:
	# Turn off the parent's Hurtbox and turn on the Shield Hurtbox
	parent_hurtbox.turn_off()
	$HurtboxComponent.turn_on()
	
	# Make the sprite visible and play the animation
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("glimmer")
	
	# Start the cooldown timer
	$Cooldown.start(cooldown)
	
	# Update the castability flags
	can_be_cast = false
	second_can_be_cast = false

# Triggered when the Shield Hurtbox detects a hit
func on_shield_struck(_health: int) -> void:
	# Turn off the Shield Hurtbox and turn on the parent's Hurtbox after delay
	$HurtboxComponent.turn_off()
	get_tree().create_timer(0.5).timeout.connect(parent_hurtbox.turn_on)
	
	# Hide the sprite and stop the animation
	$AnimatedSprite2D.hide()
	$AnimatedSprite2D.stop()
	
	# If the secondary flag is raised
	if second_can_be_cast:
		# Raise the primary flag
		can_be_cast = true
	# Else
	else:
		# Raise the secondary flag
		second_can_be_cast = true

# Triggered when the Cooldown timer expires
func on_cooldown_timeout() -> void:
	# If the secondary flag is raised
	if second_can_be_cast:
		# Raise the primary flag
		can_be_cast = true
	# Else
	else:
		# Raise the secondary flag
		second_can_be_cast = true
