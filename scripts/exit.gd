extends Node2D

@onready var bottom: InteractionArea = $BottomInteractionArea

var enemies_present: bool = false
var enemies: Array = []

func _ready() -> void:
	bottom.interact = on_player_exit
	

func on_player_exit() -> void:
	if enemies_present:
		InteractionManager.failed_interact()
	else:
		SceneManager.next_scene()

func _on_detection_area_body_entered(body: Node2D) -> void:
	enemies.append(body)
	enemies_present = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	var index: int = enemies.find(body)
	enemies.remove_at(index)
	
	if enemies.is_empty():
		enemies_present = false
