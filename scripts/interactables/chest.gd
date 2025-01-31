extends AnimatedSprite2D

@onready var chest_opening_audio_player : AudioStreamPlayer2D = $ChestOpeningAudioPlayer

func area_entered():
	$".".play("Open")
	
	chest_opening_audio_player.playing = true
