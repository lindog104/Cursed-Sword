extends PanelContainer

# Called every frame. 'delta' is the time between frames
func _process(_delta: float) -> void:
	$TextureProgressBar.value = $Timer.time_left

# Called by SceneManager when the player can cast the inputted spell
func successful_spell(cooldown: int) -> void:
	$TextureProgressBar.max_value = cooldown
	$Timer.start(cooldown)

# Called by SceneManager when the player cannot cast the inputted spell
func failed_spell() -> void:
	modulate = Color.RED
	get_tree().create_timer(0.1).timeout.connect(func() -> void:
		modulate = Color(1, 1, 1, 1)
	)
