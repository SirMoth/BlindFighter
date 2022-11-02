extends Node2D


var starting_position : Vector2
var dodge_distance : int = 400

onready var animation_player = $AnimationPlayer
onready var audioFiles = {
	"attack": $AudioPlayerContainer/AudioAttack,
	"dodge": $AudioPlayerContainer/AudioDodge,
	"return": $AudioPlayerContainer/AudioReturn,
	"parry": $AudioPlayerContainer/AudioParry,
}


func _ready():
	starting_position = $SpriteContainer.get_position()


func _process(_delta):
	pass


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
	audioFiles[sound_effect].play()
