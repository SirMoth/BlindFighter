extends Node2D


var audioFiles = {}

onready var animation_player = $AnimationPlayer


func _ready():
	audioFiles["windup"] = preload("res://Audio/Sound Effects/enemy_windup.wav")
	audioFiles["attack"] = preload("res://Audio/Sound Effects/enemy_attack.wav")


func _process(_delta):
	pass


func play_sound_effect(sound_effect : String, location : String = "default") -> void:
	var sound_effect_player = AudioStreamPlayer2D.new()
	$AudioPlayerContainer.add_child(sound_effect_player)
	
	if location != "default":
		match location:
			"left":
				sound_effect_player.position.x = -960
			"right":
				sound_effect_player.position.x = 960
			"center":
				sound_effect_player.position.x = 0
			_:
				print("Location Error")
	
	sound_effect_player.stream = audioFiles[sound_effect]
	sound_effect_player.play()
	
	yield(sound_effect_player, "finished")
	$AudioPlayerContainer.remove_child(sound_effect_player)
	print("Sound Effect Player Removed")
