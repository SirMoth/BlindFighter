extends "res://Scripts/StateMachine.gd"


# Variables to tell if the state should transition to another specific state
var transition_to_idle : bool = false
var transition_to_return_left : bool = false
var transition_to_return_right : bool = false


func _ready():
	add_state("idle")
	add_state("dodge_left")
	add_state("dodge_right")
	add_state("return_left") # Return states for coming back after dodging
	add_state("return_right")
	#add_state("attack")
	#add_state("parry")
	#add_state("stun") # State for when the player is hit by an attack
	call_deferred("set_state", states.idle) # Sets Idle as the initial state


func _state_logic(delta):
	pass


# Determines when states stransition
func _get_transition(delta):
	match state:
		states.idle:
			#if Input.is_action_just_pressed("attack"):
				#return states.attack

			#if Input.is_action_just_pressed("parry"):
				#return states.parry

			if Input.is_action_just_pressed("dodge_left"):
				return states.dodge_left

			if Input.is_action_just_pressed("dodge_right"):
				return states.dodge_right


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.animation_player.play("idle")

		#states.attack:
			#parent.animation_player.play("attack")

		#states.parry:
			#parent.animation_player.play("parry")

		states.dodge_left:
			parent.animation_player.play("dodge_left")
			

		states.dodge_right:
			parent.animation_player.play("dodge_right")

		# Returning from the left requeres jumping to the right and vice versa
		states.return_left:
			parent.animation_player.play("dodge_right")

		states.return_right:
			parent.animation_player.play("dodge_left")


# Function to place one-shot code on exiting a state
func _exit_state(old_state, new_state):
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"dodge_left":
			transition_to_return_left = true
		"dodge_right":
			transition_to_return_right = true
		"return_left", "return_right":
			transition_to_idle = true
