extends Node2D

## Sword control script
# 
# Handles the control of the sword by the player's mouse

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var sword_swing_audio_player : AudioStreamPlayer2D = $SwordSwingAudioPlayer
@onready var hitbox : HitboxComponent = $HitboxComponent

var held: bool = true

# Called every frame. 'delta' is the time between frames
func _process(_delta: float) -> void:
	# Rotates the node to point towards the provided vector
	look_at(get_global_mouse_position())

# Called whenever a key or action is pressed
func _input(event: InputEvent) -> void:
	# If the Attack action is pressed
	if event.is_action_pressed("attack"):
		# Turn on the Hitbox
		hitbox.turn_on()
		
		# Play the animation
		anim_player.play("swing")
		
		# Play the attack audio
		sword_swing_audio_player.playing = true
	
	# If the Parry action is pressed
	if event.is_action_pressed("parry"):
		# Play the animation
		anim_player.play("parry")

# Triggered when the current animation finishes
func on_animation_finished(_anim_name: StringName) -> void:
	# Turn off the Hitbox
	hitbox.turn_off()
	
	# Reset the sword
	anim_player.play("RESET")
