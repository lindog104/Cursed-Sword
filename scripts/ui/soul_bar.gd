extends TextureProgressBar

var animated_bar: AnimatedTexture = load("res://assets/Gui Elements/animated_soul_bar.tres")
@onready var texture_rect: TextureRect = $"../TextureRect"

func _on_value_changed(value: float) -> void:
	if value == max_value:
		texture_rect.texture = animated_bar
	else:
		texture_rect.texture = null
