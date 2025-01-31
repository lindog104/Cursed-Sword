extends AnimatedSprite2D




func body_entered(_body):
	play("Open")

func animation_finished():
	$Area2D.body_entered.disconnect(body_entered)
