extends AnimatedSprite2D

var gem: PackedScene = load("res://scenes/Items/gem.tscn")

func body_entered(_body):
	play("Open")

func animation_finished():
	$Area2D.body_entered.disconnect(body_entered)
	
	owner.add_child(gem.instantiate())
