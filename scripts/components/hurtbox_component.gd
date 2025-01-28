extends Area2D
class_name HurtboxComponent

## Hurtbox class
#
# Handles the acceptance of damage from a Hitbox

signal health_changed

@onready var health : int = max_health

@export var max_health : int = 50

# Disables the Area2D and its CollisionShape
func turn_off() -> void:
	# Changes the properties at the next available frame to prevent request loss
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	$CollisionShape2D.set_deferred("disabled", true)

# Enables the Area2D and its CollisionShape
func turn_on() -> void:
	# Changes the properties at the next available frame to prevent request loss
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)
	$CollisionShape2D.set_deferred("disabled", false)

# Triggered when an Area2D overlaps with this one
func on_area_entered(area: Area2D) -> void:
	# If the detected area has a different parent and grandparent
	if (area.get_parent() != get_parent() 
	and area.get_parent().get_parent() != get_parent().get_parent()):
		# If the detected area was a Hitbox
		if area is HitboxComponent:
			# Reduce health by the Hitbox's damage
			health -= area.damage
			health_changed.emit(health) 
			
			# If the owner is a child of the Entity class
			if owner is Entity:
				# Pass the current health to the owner
				owner.on_damage_taken(health)
				
				# Pass the knockback from the Hitbox to the owner
				owner.get_knocked_back(area.global_position.direction_to(global_position))
				
			# If the owner is a child of the Host class
			elif owner is Host:
				# Pass the current health through the host to the owner
				owner.player_reference.on_damage_taken(health)
				
				# Pass the knockback from the Hitbox through the host to the owner
				owner.player_reference.get_knocked_back(
					area.global_position.direction_to(global_position))
	
