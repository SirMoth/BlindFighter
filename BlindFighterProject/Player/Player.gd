extends Node2D


var starting_position : Vector2
var dodge_distance : int = 400
var audioFiles = {}

onready var animation_player = $AnimationPlayer


func _ready():
	starting_position = $SpriteContainer.get_position()
	audioFiles["player_attack"] = preload("res://Audio/player_attack.wav")
	audioFiles["player_dodge"] = preload("res://Audio/player_dodge.wav")
	audioFiles["player_return"] = preload("res://Audio/player_return.wav")


func _process(_delta):
	pass


func move(location : String = "start") -> void:
	match location:
		"left":
			var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property($SpriteContainer, "position", Vector2(starting_position.x - dodge_distance, starting_position.y), animation_player.current_animation_length)
		"right":
			var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property($SpriteContainer, "position", Vector2(starting_position.x + dodge_distance, starting_position.y), animation_player.current_animation_length)
		"start":
			var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property($SpriteContainer, "position", starting_position, animation_player.current_animation_length)
		_:
			print("Error: Incorrect location given for move() function")


func play_sound_effect(sound_effect : String) -> void:
	var sound_effect_player = AudioStreamPlayer2D.new()
	add_child($AudioPlayerContainer)
	sound_effect_player.stream = audioFiles[sound_effect]
	sound_effect_player.play()
	
	yield(sound_effect_player, "finished")
	remove_child(sound_effect_player)
	print("Sound Effect Player Removed")
