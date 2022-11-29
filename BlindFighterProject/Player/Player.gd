extends Node2D


var starting_position : Vector2
var dodge_distance : int = 400
var audioFiles = {}

onready var animation_player = $AnimationPlayer


func _ready():
	starting_position = $SpriteContainer.get_position()
	audioFiles["attack"] = preload("res://Audio/Sound Effects/player_attack.wav")
	audioFiles["dodge"] = preload("res://Audio/Sound Effects/player_dodge.wav")
	audioFiles["return"] = preload("res://Audio/Sound Effects/player_return.wav")
	audioFiles["parry"] = preload("res://Audio/Sound Effects/player_parry.wav")
	audioFiles["damaged"] = preload("res://Audio/Sound Effects/player_damaged.wav")


func _process(_delta):
	pass


# Placeholder take_damage function
func take_damage(damage):
	play_sound_effect("damaged")
	print("You took ", damage, " damage.")


func move(location : String = "start") -> void:
	match location:
		"left":
			# Tween sprite
			var animation_tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			animation_tween.tween_property($SpriteContainer, "position", Vector2(starting_position.x - dodge_distance, starting_position.y), animation_player.current_animation_length)
			# Tween 2D audio
			var audio_tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			audio_tween.tween_property($AudioPlayerContainer, "position", Vector2(0, $AudioPlayerContainer.get_position().y), animation_player.current_animation_length)
		"right":
			var animation_tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			animation_tween.tween_property($SpriteContainer, "position", Vector2(starting_position.x + dodge_distance, starting_position.y), animation_player.current_animation_length)
			
			var audio_tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			audio_tween.tween_property($AudioPlayerContainer, "position", Vector2(1920, $AudioPlayerContainer.get_position().y), animation_player.current_animation_length)
		"start":
			var animation_tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			animation_tween.tween_property($SpriteContainer, "position", starting_position, animation_player.current_animation_length)
			
			var audio_tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			audio_tween.tween_property($AudioPlayerContainer, "position", Vector2(960, $AudioPlayerContainer.get_position().y), animation_player.current_animation_length)
		_:
			print("Error: Incorrect location given for move() function")


func play_sound_effect(sound_effect : String) -> void:
	var sound_effect_player = AudioStreamPlayer2D.new()
	$AudioPlayerContainer.add_child(sound_effect_player)
	sound_effect_player.volume_db += 1 # Change to a non-static variable
	sound_effect_player.stream = audioFiles[sound_effect]
	sound_effect_player.play()
	
	yield(sound_effect_player, "finished")
	$AudioPlayerContainer.remove_child(sound_effect_player)
