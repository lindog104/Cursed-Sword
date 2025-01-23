extends Node
class_name StateMachine
# Custom class to handle state transistions

@export var initialState : State
var currentState : State
var states : Dictionary = {}

# Called when node enters the scene tree for the first time
func _ready() -> void:
	
	# Cycles through the children of this node
	for child : Node in get_children():
		
		# If the child inherits from the State class
		if child is State:
			
			# The child is added to the states dictionary
			states[child.name.to_lower()] = child
			
			# And their signals are connected
			child.transitioned.connect(on_child_transition)
			child.finished.connect(on_final_state_finish)
	
	# If a State has been assigned to the initial state export
	if initialState:
		
		# Call that State's enter() and set it as the currentState
		initialState.enter()
		currentState = initialState

# Called every frame
func _process(delta: float) -> void:
	
	# If currentState is not null, call that State's update()
	if currentState:
		currentState.update(delta)

# Called every physics frame
func _physics_process(delta: float) -> void:
	
	# If currentState is not null, call that State's physicsUpdate()
	if currentState:
		currentState.physicsUpdate(delta)

# Called whenever a child State emits their transitioned signal
# Handles transitions between states
func on_child_transition(sourceState: State, newStateName: String) -> void:
	
	# Aborts transition if signal wasnt emitted by the currentState
	if sourceState != currentState:
		return
	
	# Retrieves the newState from the states dictionary
	var newState: State = states.get(newStateName.to_lower())
	
	# Aborts transition is newState is not in the states dictionary
	if !newState:
		return
	
	# Exits the currentState
	if currentState:
		currentState.exit()
	
	# Enters the newState
	newState.enter()
	#print(newStateName)
	
	# Assigns the newState as the currentState
	currentState = newState

# Called when an external event triggers a State change
func on_external_state_change(newStateName: String) -> void:
	
	# Retrieves the newState from the states dictionary
	var newState: State = states.get(newStateName.to_lower())
	
	# Aborts transition is newState is not in the states dictionary
	if !newState:
		return
	
	# Exits the currentState
	if currentState:
		currentState.exit()
	
	# Enters the newState
	newState.enter()
	#print(newStateName)
	
	# Assigns the newState as the currentState
	currentState = newState

# Called when the final State emits the finished signal
# Shuts off the State Machine
func on_final_state_finish() -> void:
	# Disables _process() and _physics_process()
	set_process(false)
	set_physics_process(false)
	
	# Calls owner to emit their death signal
	if owner.has_method("signal_death"):
		owner.signal_death()
