extends "res://Scripts/StateMachine.gd"


func _ready():
	add_state("idle")
	add_state("dodge_left")
	add_state("dodge_right")
	add_state("return_left") # Return states for coming back after dodging
	add_state("return_right")
	#add_state("attack")
	#add_state("hitstun") # State for when the player is hit by an attack
	call_deferred("set_state", states.idle)


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
