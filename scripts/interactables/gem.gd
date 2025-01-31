extends Sprite2D

@export var value: int = 100

var sprites: Array = [
	"res://assets/Items/hilt_gem_blue.png",
	"res://assets/Items/hilt_gem_green.png",
	"res://assets/Items/hilt_gem_purple.png",
	"res://assets/Items/hilt_gem_red.png"
]

func _ready() -> void:
	var random: int = randi_range(0, sprites.size())
	
	value *= random
	texture = load(sprites[random])

func on_gem_picked_up(_area: Area2D) -> void:
	SceneManager.on_gem_picked_up(value)
