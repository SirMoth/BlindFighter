extends "res://Scripts/StateMachine.gd"


# Variables to tell if the state should transition to another specific state
var transition_to_idle : bool = false
var transition_to_attack_left : bool = false
var transition_to_attack_right : bool = false
var transition_to_attack_center : bool = false


func _ready():
	add_state("idle")
	add_state("windup_left")
	add_state("attack_left")
	add_state("windup_right")
	add_state("attack_right")
	add_state("windup_center")
	add_state("attack_center")
	call_deferred("set_state", states.idle) # Sets Idle as the initial state


func _state_logic(delta):
	pass


# Determines when states stransition
func _get_transition(delta):
	match state:
		states.idle:
			if Input.is_action_just_pressed("enemy_attack_left"):
				return states.windup_left

			if Input.is_action_just_pressed("enemy_attack_right"):
				return states.windup_right

			if Input.is_action_just_pressed("enemy_attack_center"):
				return states.windup_center
		
		states.windup_left:
			if transition_to_attack_left == true:
				transition_to_attack_left = false
				return states.attack_left
		
		states.attack_left:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
		
		states.windup_right:
			if transition_to_attack_right == true:
				transition_to_attack_right = false
				return states.attack_right
		
		states.attack_right:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
		
		states.windup_center:
			if transition_to_attack_center == true:
				transition_to_attack_center = false
				return states.attack_center
		
		states.attack_right:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.animation_player.play("idle")

		states.windup_left:
			parent.animation_player.play("windup_left")

		states.attack_left:
			parent.animation_player.play("attack_left")

		states.windup_right:
			parent.animation_player.play("windup_right")

		states.attack_right:
			parent.animation_player.play("attack_right")

		states.windup_center:
			parent.animation_player.play("windup_center")

		states.attack_center:
			parent.animation_player.play("attack_center")


# Function to place one-shot code on exiting a state
func _exit_state(old_state, new_state):
	pass




func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"windup_left":
			if state == states.windup_left:
				transition_to_attack_left = true

		"attack_left":
			if state == states.attack_left:
				transition_to_idle = true

		"windup_right":
			if state == states.windup_right:
				transition_to_attack_right = true

		"attack_right":
			if state == states.attack_right:
				transition_to_idle = true

		"windup_center":
			if state == states.windup_center:
				transition_to_attack_center = true

		"attack_center":
			if state == states.attack_center:
				transition_to_idle = true
