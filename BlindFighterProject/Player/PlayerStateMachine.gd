extends StateMachine


# Variables to tell if the state should transition to another specific state
var transition_to_idle : bool = false
var transition_to_return_left : bool = false
var transition_to_return_right : bool = false
var can_cancel_from_attack : bool = false


func _ready():
	add_state("idle")
	add_state("attack")
	add_state("parry")
	add_state("dodge_left")
	add_state("dodge_right")
	add_state("return_left") # Return states for coming back after dodging
	add_state("return_right")
	#add_state("stun") # State for when the player is hit by an attack
	call_deferred("set_state", states.idle) # Sets Idle as the initial state


func _state_logic(delta):
	pass


# Determines when states stransition
func _get_transition(delta):
	match state:
		states.idle:
			if Input.is_action_just_pressed("attack"):
				return states.attack

			if Input.is_action_just_pressed("parry"):
				return states.parry

			if Input.is_action_just_pressed("dodge_left"):
				return states.dodge_left

			if Input.is_action_just_pressed("dodge_right"):
				return states.dodge_right
		
		states.attack:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
			
			if can_cancel_from_attack == true:
				if Input.is_action_just_pressed("attack"):
					return states.attack
				if Input.is_action_just_pressed("parry"):
					return states.parry
				if Input.is_action_just_pressed("dodge_left"):
					return states.dodge_left
				if Input.is_action_just_pressed("dodge_right"):
					return states.dodge_right
		
		states.parry:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
		
		states.dodge_left:
			if transition_to_return_left == true:
				transition_to_return_left = false
				return states.return_left
		
		states.dodge_right:
			if transition_to_return_right == true:
				transition_to_return_right = false
				return states.return_right
		
		states.return_left:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
				
			if Input.is_action_just_pressed("attack"):
				return states.attack

			if Input.is_action_just_pressed("parry"):
				return states.parry
		
		states.return_right:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
				
			if Input.is_action_just_pressed("attack"):
				return states.attack

			if Input.is_action_just_pressed("parry"):
				return states.parry


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.animation_player.play("idle")
			$"%HurtBoxController".idle()

		states.attack:
			parent.animation_player.play("attack")
			if parent.animation_player.current_animation == "attack":
				parent.animation_player.stop()
				parent.animation_player.play("attack")
			parent.play_sound_effect("attack")
			$"%HurtBoxController".idle()
			$"%HitBox".activate(0.25, 1, 0.08)
			yield(get_tree().create_timer(0.35), "timeout")
			if state == states.attack:
				can_cancel_from_attack = true
				print("Can cancel")

		states.parry:
			parent.animation_player.play("parry")
			parent.play_sound_effect("parry")
			$"%HurtBoxController".parry()

		states.dodge_left:
			parent.animation_player.play("dodge_left")
			parent.play_sound_effect("dodge")
			parent.play_sound_effect("dodge_voice")
			parent.move("left")
			$"%HurtBoxController".dodge_left()

		states.dodge_right:
			parent.animation_player.play("dodge_right")
			parent.play_sound_effect("dodge")
			parent.play_sound_effect("dodge_voice")
			parent.move("right")
			$"%HurtBoxController".dodge_right()

		# Returning from the left requeres jumping to the right and vice versa
		states.return_left:
			parent.animation_player.play("dodge_right")
			parent.play_sound_effect("return")
			parent.play_sound_effect("return_voice")
			parent.move("start")
			$"%HurtBoxController".dodge_left()

		states.return_right:
			parent.animation_player.play("dodge_left")
			parent.play_sound_effect("return")
			parent.play_sound_effect("return_voice")
			parent.move("start")
			$"%HurtBoxController".dodge_right()


# Function to place one-shot code on exiting a state
func _exit_state(old_state, new_state):
	match old_state:
		states.attack:
			if can_cancel_from_attack == true:
				can_cancel_from_attack = false


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"attack":
			if state == states.attack:
				transition_to_idle = true
		"parry":
			if state == states.parry:
				transition_to_idle = true
		"dodge_left":
			if state == states.dodge_left:
				transition_to_return_left = true
			if state == states.return_right:
				transition_to_idle = true
		"dodge_right":
			if state == states.dodge_right:
				transition_to_return_right = true
			if state == states.return_left:
				transition_to_idle = true
