extends StateMachine


# Variables to tell if the state should transition to another specific state
var transition_to_idle : bool = false
var transition_to_windup_left : bool = false
var transition_to_attack_left : bool = false
var transition_to_windup_right : bool = false
var transition_to_attack_right : bool = false
var transition_to_windup_center : bool = false
var transition_to_attack_center : bool = false
var transition_to_new_attack_left : bool = false
var transition_to_new_attack_right : bool = false
var transition_to_new_attack_center : bool = false


#Signal the AI uses to determine attack timings
signal attack_finished


func _ready():
	add_state("idle")
	add_state("windup_left")
	add_state("attack_left")
	add_state("windup_right")
	add_state("attack_right")
	add_state("windup_center")
	add_state("attack_center")
	call_deferred("set_state", states.idle) # Sets Idle as the initial state
	add_state("new_attack_left")
	add_state("new_attack_right")
	add_state("new_attack_center")


func _state_logic(delta):
	pass


# Determines when states stransition
func _get_transition(delta):
	match state:
		states.idle:
			if transition_to_windup_left == true:
				transition_to_windup_left = false
				return states.windup_left

			if transition_to_windup_right == true:
				transition_to_windup_right = false
				return states.windup_right

			if transition_to_windup_center == true:
				transition_to_windup_center = false
				return states.windup_center
				
			if transition_to_new_attack_left == true:
				transition_to_new_attack_left = false
				return states.new_attack_left

			if transition_to_new_attack_right == true:
				transition_to_new_attack_right = false
				return states.new_attack_right

			if transition_to_new_attack_center == true:
				transition_to_new_attack_center = false
				return states.new_attack_center
		
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
		
		states.attack_center:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
		
		states.new_attack_left:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
		
		states.new_attack_right:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle
		
		states.new_attack_center:
			if transition_to_idle == true:
				transition_to_idle = false
				return states.idle


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.animation_player.play("idle")
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])

		states.windup_left:
			parent.animation_player.play("windup_left")
			parent.play_sound_effect("windup_side", "left")
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])

		states.attack_left:
			parent.animation_player.play("attack_left")
			parent.play_sound_effect("attack", "left")
			$"%HitBox".set_location($"%HitBox".Location.LEFT)
			$"%HitBox".activate(0.5, 1, 0)
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])

		states.windup_right:
			parent.animation_player.play("windup_right")
			parent.play_sound_effect("windup_side", "right")
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])

		states.attack_right:
			parent.animation_player.play("attack_right")
			parent.play_sound_effect("attack", "right")
			$"%HitBox".set_location($"%HitBox".Location.RIGHT)
			$"%HitBox".activate(0.5, 1, 0)
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])

		states.windup_center:
			parent.animation_player.play("windup_center")
			parent.play_sound_effect("windup_center", "center")
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])

		states.attack_center:
			parent.animation_player.play("attack_center")
			parent.play_sound_effect("attack2", "center")
			$"%HitBox".set_location($"%HitBox".Location.CENTER)
			$"%HitBox".activate(0.25, 1, 0.25)
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])

		states.new_attack_left:
			parent.animation_player.play("new_attack_left")
			parent.play_sound_effect("windup_side", "left")
			$"%HitBox".set_location($"%HitBox".Location.LEFT)
			$"%HitBox".activate(0.15, 1, 0.5)
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])
			yield(get_tree().create_timer(0.5), "timeout")
			parent.play_sound_effect("attack2", "left")

		states.new_attack_right:
			parent.animation_player.play("new_attack_right")
			parent.play_sound_effect("windup_side", "right")
			$"%HitBox".set_location($"%HitBox".Location.RIGHT)
			$"%HitBox".activate(0.15, 1, 0.5)
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])
			yield(get_tree().create_timer(0.5), "timeout")
			parent.play_sound_effect("attack2", "right")

		states.new_attack_center:
			parent.animation_player.play("new_attack_center")
			parent.play_sound_effect("windup_center", "center")
			$"%HitBox".set_location($"%HitBox".Location.CENTER)
			$"%HitBox".activate(0.15, 1, 0.5)
			$"%HurtBox".set_status($"%HurtBox".Condition.IDLE, $"%HurtBox".color["idle"])
			yield(get_tree().create_timer(0.5), "timeout")
			parent.play_sound_effect("attack2", "center")


# Function to place one-shot code on exiting a state
func _exit_state(old_state, new_state):
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"windup_left":
			if state == states.windup_left:
				yield(get_tree().create_timer(0.25), "timeout")
				transition_to_attack_left = true

		"attack_left":
			if state == states.attack_left:
				transition_to_idle = true
				emit_signal("attack_finished")

		"windup_right":
			if state == states.windup_right:
				yield(get_tree().create_timer(0.25), "timeout")
				transition_to_attack_right = true

		"attack_right":
			if state == states.attack_right:
				transition_to_idle = true
				emit_signal("attack_finished")

		"windup_center":
			if state == states.windup_center:
				yield(get_tree().create_timer(0.25), "timeout")
				transition_to_attack_center = true

		"attack_center":
			if state == states.attack_center:
				transition_to_idle = true
				emit_signal("attack_finished")

		"new_attack_left":
			if state == states.new_attack_left:
				transition_to_idle = true
				emit_signal("attack_finished")

		"new_attack_right":
			if state == states.new_attack_right:
				transition_to_idle = true
				emit_signal("attack_finished")

		"new_attack_center":
			if state == states.new_attack_center:
				transition_to_idle = true
				emit_signal("attack_finished")


func _on_AI_attack_left():
	transition_to_windup_left = true # Old attack animation
	#transition_to_new_attack_left = true # New attack animation

func _on_AI_attack_right():
	transition_to_windup_right = true # Old attack animation
	#transition_to_new_attack_right = true # New attack animation

func _on_AI_attack_center():
	transition_to_windup_center = true # Old attack animation
	#transition_to_new_attack_center = true # New attack animation
