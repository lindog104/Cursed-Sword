extends Node

## Scene Manager Script
#
# Handles the transitions and interactions between different children in
# the game scene

@onready var tempt_game: PackedScene = load("res://scenes/tempt_game.tscn")
@onready var game_over: PackedScene = load("res://scenes/game_over.tscn")

var percent_of_slowdown: float = 0.5
var player: Entity
var hud: Control

# Triggered by the Player's Host's hurtbox
func on_health_changed(current_health: int) -> void:
	# Safety check the hud reference
	check_hud_reference()
	
	# Pass the updated health to the HUD
	hud.update_health(current_health)

# Triggered by the player entering the Dropped state
# Or a Stunned enemy signaling a temptation input
func play_temptation_minigame(caller: Node2D, target_host: PackedScene, dropped: bool = false) -> void:
	# If the current scene does not already have the Temptation game as a child
	if !get_tree().current_scene.has_node("TemptGame"):
		# Add it
		get_tree().current_scene.add_child(tempt_game.instantiate())
	
	# Initialize a reference to the current scene's Temptation game child
	var temptation_game: CanvasLayer = get_tree().current_scene.get_node("TemptGame")
	
	# Initialize the acceleration factor that is applied to the minigame
	# to make it appear as normal time
	var speedup_modifier : float = 1 / percent_of_slowdown
	
	# Slow down the game
	Engine.time_scale = percent_of_slowdown
	
	# Call the minigame and store its result
	var player_won_minigame = temptation_game.play_minigame(speedup_modifier)
	
	# If the minigame was won
	if player_won_minigame:
		# Assign the new host to the player
		pass_new_host(caller, target_host, true)
		
	# If the minigame was lost and the player was dropped
	elif !player_won_minigame and dropped:
		# Handle game over
		on_player_death()
	# If the minigame was lost but the player is held
	elif !player_won_minigame and !dropped:
		# Handle temptation failure
		pass
	
	# Resume normal speed
	Engine.time_scale = 1.0

# Triggered by a Dead enemy signaling a possession input
# Or called internally when Tempt successful
func pass_new_host(caller: Node2D, target_host: PackedScene, tempted: bool = false) -> void:
	# Instance the new host file
	var new_host: Host = target_host.instantiate()
	
	# Extract the player's current host
	var old_host: Host = player.host
	
	# Safety check the hud reference
	check_hud_reference()
	
	# If new host is from a live enemy
	if tempted:
		# Reset the player's health to 3 hits
		hud.update_health(75)
	# If new host is from a dead enemy
	else:
		# Reset the player's health to two hits
		hud.update_health(50)
	
	# Add the new host as a child of the player
	player.add_child(new_host)
	player.host = new_host
	
	# "Drop" the former host body (not sure how to do this yet)
	# Remove the old host from the player
	old_host.queue_free()
	
	# Move the player to the position of the new host
	player.global_position = caller.global_position
	
	# Delete the enemy that was possessed
	caller.queue_free()

# Called internally before using the hud variable
func check_hud_reference() -> void:
	# If the hud reference is empty
	if !hud:
		# Grab a reference to the HUD
		hud = get_tree().current_scene.get_node("CanvasLayer/HUD")

# Called internally when game over occurs
# Or triggered by the Player death or dropped states
func on_player_death() -> void:
	# Disable the player scene
	player.call_deferred("set_process_mode", 4)
	
	# Display the Game Over Screen
	get_tree().current_scene.add_child(game_over.instantiate())
