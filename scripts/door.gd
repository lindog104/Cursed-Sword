extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var top: InteractionArea = $TopInteractionArea
@onready var bottom: InteractionArea = $BottomInteractionArea
@onready var timer: Timer = $Timer
@onready var anim_player: AnimationPlayer = $AnimationPlayer

@export var is_locked: bool = false

func _ready() -> void:
	if is_locked:
		sprite.texture = load("res://assets/environment/locked_door.png")
		
		top.action_name = "unlock"
		bottom.action_name = "unlock"
		
		top.interact = unlock
		bottom.interact = unlock
	else:
		top.interact = open_down
		bottom.interact = open_up

func open_down() -> void:
	anim_player.play("open_down")
	
	top.turn_off()
	bottom.turn_off()
	
	timer.start()
	timer.timeout.connect(func() -> void:
		anim_player.play("close_up")
		
		top.turn_on()
		bottom.turn_on()
		)

func open_up() -> void:
	anim_player.play("open_up")
	
	top.turn_off()
	bottom.turn_off()
	
	timer.start()
	timer.timeout.connect(func() -> void:
		anim_player.play("close_down")
		
		top.turn_on()
		bottom.turn_on()
		)

func unlock() -> void:
	if SceneManager.on_key_use_attempt():
		is_locked = false
		sprite.texture = load("res://assets/environment/door.png")
		
		top.interact = open_down
		bottom.interact = open_up
		
		top.action_name = "open"
		bottom.action_name = "open"
	else:
		InteractionManager.failed_interact()
