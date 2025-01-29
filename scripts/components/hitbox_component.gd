extends Area2D
class_name HitboxComponent

## Hitbox class
#
# Handles dealing damage to hurtboxes

@export var damage : int = 5
@export var disabled : bool = false

# Called when the scene enters the scene tree for the first time
func _ready() -> void:
	# Checks if this Hitbox is initially disabled
	if disabled:
		# Shuts off the Hitbox
		turn_off()

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
