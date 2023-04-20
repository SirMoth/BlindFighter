# This code is designed to progress the music through different stages of music as the game goes on.

extends AudioStreamPlayer


var musicFiles = {}
var current_music_file
var initial_enemy_health : int
var initial_enemy_health_received : bool = false
var current_enemy_health : int
var number_of_shifts : int = 4 # This is the number of times the enemy damage threshold can change the mustc.
var damage_to_shift : int # This is the amount of damage required to progress the music.
var current_music_phase : int = 0


func _ready() -> void:
	connect("finished", self, "_on_finished")
	musicFiles["c1"] = preload("res://Audio/Music/VGF_C1.wav")   # Intro
	musicFiles["c2"] = preload("res://Audio/Music/VGF_C2.wav")   # Intro
	musicFiles["c3"] = preload("res://Audio/Music/VGF_C3.wav")   # Intro
	musicFiles["c4"] = preload("res://Audio/Music/VGF_C4.wav")   # Intro
	musicFiles["c5"] = preload("res://Audio/Music/VGF_C5.wav")   # Loopable
	musicFiles["c6"] = preload("res://Audio/Music/VGF_C6.wav")   # Loopable
	musicFiles["c7"] = preload("res://Audio/Music/VGF_C7.wav")   # Loopable
	musicFiles["c8"] = preload("res://Audio/Music/VGF_C8.wav")   # Loopable
	musicFiles["c9"] = preload("res://Audio/Music/VGF_C9.wav")   # Bridge
	musicFiles["c10"] = preload("res://Audio/Music/VGF_C10.wav") # Bridge
	musicFiles["c11"] = preload("res://Audio/Music/VGF_C11.wav") # Loopable
	
	set_stream(musicFiles["c1"])
	play()
	current_music_file = "c1"

func _on_finished() -> void:
	match current_music_file:
		"c1":
			set_music("c2")
		"c2":
			if current_music_phase == 0:
				set_music("c3")
			else:
				set_music(get_music_to_shift_to())
		"c3":
			if current_music_phase == 0:
				set_music("c4")
			else:
				set_music(get_music_to_shift_to())
		"c4":
			if current_music_phase == 0:
				set_music("c5")
			else:
				set_music(get_music_to_shift_to())
		"c5":
				set_music(get_music_to_shift_to())
		"c6":
				set_music(get_music_to_shift_to())
		"c7":
				set_music(get_music_to_shift_to())
		"c8":
				set_music(get_music_to_shift_to())
		"c9":
			set_stream(musicFiles["c10"])
			play()
			current_music_file = "c10"
		"c10":
			set_stream(musicFiles["c11"])
			play()
			current_music_file = "c11"
		"c11":
			set_music("c11")


func set_music(music_name):
	set_stream(musicFiles[music_name])
	play()
	current_music_file = music_name


func _on_Enemy_enemy_health_changed(new_health) -> void:
	if initial_enemy_health_received == false:
		initial_enemy_health = new_health
		set_damage_to_shift()
		initial_enemy_health_received = true
	if initial_enemy_health - new_health >= damage_to_shift:
		current_music_phase = (initial_enemy_health - new_health) / damage_to_shift
	

func set_damage_to_shift() -> void:
	damage_to_shift = initial_enemy_health / number_of_shifts


func get_music_to_shift_to() -> String:
	match current_music_phase:
		0:
			return "c5"
		1:
			return "c6"
		2:
			return "c7"
		3:
			return "c8"
		4:
			return "c9"
	return "c1"
