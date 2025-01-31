extends Sprite2D


func key_picked_up(_area: Area2D):
	SceneManager.on_key_picked_up()
	
	queue_free()
