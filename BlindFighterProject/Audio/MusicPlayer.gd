# This code is designed to progress the music through different stages of music as the game goes on.

extends AudioStreamPlayer


var musicFiles = {}
var initial_enemy_health : int
var initial_enemy_health_received : bool = false
var current_enemy_health : int
var damage_to_change_music : int # This is the amount of damage required to progress the music.


func _ready() -> void:
	connect("finished", self, "_on_finished")
	musicFiles["c1"] = preload("res://Audio/Music/VGF_C1.wav")  # Intro
	musicFiles["c2"] = preload("res://Audio/Music/VGF_C2.wav")  # Intro
	musicFiles["c3"] = preload("res://Audio/Music/VGF_C3.wav")  # Intro
	musicFiles["c4"] = preload("res://Audio/Music/VGF_C4.wav")  # Intro
	musicFiles["c5"] = preload("res://Audio/Music/VGF_C5.wav")  # Loopable
	musicFiles["c6"] = preload("res://Audio/Music/VGF_C6.wav")  # Loopable
	musicFiles["c7"] = preload("res://Audio/Music/VGF_C7.wav")  # Loopable
	musicFiles["c8"] = preload("res://Audio/Music/VGF_C8.wav")  # Loopable
	musicFiles["c9"] = preload("res://Audio/Music/VGF_C9.wav")  # Bridge
	musicFiles["c10"] = preload("res://Audio/Music/VGF_C10.wav")# Bridge
	musicFiles["c11"] = preload("res://Audio/Music/VGF_C11.wav")# Loopable
	
	set_stream(musicFiles["c1"])
	play()

func _on_finished() -> void:
	match stream:
		musicFiles["c1"]:
			set_stream(musicFiles["c2"])
