extends Node
class_name StateMachine


var state = null setget set_state
var previous_state = null
var states = {}


onready var parent = get_parent()


func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			set_state(transition)


func _state_logic(delta):
	pass


# Determines which states can transition to which other states
func _get_transition(delta):
	return null


# Function to place one-shot code that activates on a state being entered, like tweening and timers
func _enter_state(new_state, old_state):
	pass


# Function to place one-shot code on exiting a state
func _exit_state(old_state, new_state):
	pass


func set_state(new_state):
	previous_state = state
	state = new_state
	
	if previous_state != null:
		_exit_state(previous_state, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state)


# Adds possible states to the states dictionary
func add_state(state_name):
	states[state_name] = states.size()
