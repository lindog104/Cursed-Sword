extends Area2D
class_name InteractionArea

## Base Interaction Area class
#
# Handles the interaction call of any scene that prompts the player for an
# input. The exports are values that should be cutomized to match the parent
# scene. The Interact variable should be set by the parent scene to reference
# the function that should be called when the player interacts with the parent
# scene.

#@export_enum("Press", "Hold") var action_type = 0
@export var action_type_string: String = "press"
@export var action_name: String = "interact"
@export var centering_correction: float = 12.0
@export var disabled : bool = false

# Generic interaction call
# Saved as a variable to make customization by parent easier
var interact : Callable = func() -> void:
	pass

# Called when the scene enters the scene tree for the first time
func _ready() -> void:
	# If the area is initially disabled
	if disabled:
		# Turn off the interaction area
		turn_off()

# Called when a body enters the CollisionArea
func _on_body_entered(_body: Node2D) -> void:
	# Adds self to the InteractionManager's active_areas
	InteractionManager.register_area(self)

# Called when a body exits the CollisionArea
func _on_body_exited(_body: Node2D) -> void:
	# Removes self from the InteractionManager's active_areas
	InteractionManager.unregister_area(self)

# Called by parent to disable interactability
func turn_off() -> void:
	# Remove self from active_areas, disable ability to detect or be detected
	InteractionManager.unregister_area(self)
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)

# Called by parent to reenable interactability
func turn_on() -> void:
	# Enable ability to detect and be detected
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
