extends Node
class_name State
# Parent class for states


# Signal to be used to trigger state transistions
signal transitioned

# Signal to be used to trigger end of state machine
signal finished

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
