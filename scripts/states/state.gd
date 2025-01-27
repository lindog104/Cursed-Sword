extends Node
class_name State

## Base State Class
#
# Establishes the generic versions of the State functions
# A State is intended to be used to isolate portions of code that run 
# independently to ease later modification

# Signal to be used to trigger state transistions
signal transitioned

# Signal to be used to trigger end of state machine
signal finished

# Export to hold the parent node of the state machine
@export var parent : CharacterBody2D

# Generic function to be called when entering this state 
func enter()-> void:
	pass

# Generic function to be called when exiting this state
func exit() -> void:
	pass

# Generic funciton to be called every frame
func update(_delta: float) -> void:
	pass

# Generic function to be called every physics frame
func physicsUpdate(_delta: float) -> void:
	pass
