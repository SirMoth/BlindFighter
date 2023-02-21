extends Node2D


var starting_health : int = 10
var current_health : int = starting_health
var audioFiles = {}

onready var animation_player = $AnimationPlayer

signal enemy_health_changed(new_health)


func _ready():
	emit_signal("enemy_health_changed", starting_health)
	audioFiles["windup"] = preload("res://Audio/Sound Effects/enemy_windup.wav")
	audioFiles["windup_side"] = preload("res://Audio/Sound Effects/enemy_windup_side.wav")
	audioFiles["windup_center"] = preload("res://Audio/Sound Effects/enemy_windup_center.wav")
	audioFiles["attack"] = preload("res://Audio/Sound Effects/enemy_attack.wav")
	audioFiles["attack2"] = preload("res://Audio/Sound Effects/enemy_attack2.wav")
	audioFiles["player_hit"] = preload("res://Audio/Sound Effects/player_hit.wav")


func _process(_delta):
	pass


# Placeholder take_damage function
func take_damage(damage):
	print("Enemy took ", damage, " damage.")
	play_sound_effect("player_hit")
	current_health -= damage
	emit_signal("enemy_health_changed", current_health)


func play_sound_effect(sound_effect : String, location : String = "default") -> void:
	var sound_effect_player = AudioStreamPlayer2D.new()
	$AudioPlayerContainer.add_child(sound_effect_player)
	sound_effect_player.volume_db += 1 # Change to a non-static variable
	
	if location != "default":
		match location:
			"left":
				sound_effect_player.position.x = -960
				sound_effect_player.volume_db += 3
			"right":
				sound_effect_player.position.x = 960
				sound_effect_player.volume_db += 3
			"center":
				sound_effect_player.position.x = 0
			_:
				print("Location Error")
	
	sound_effect_player.stream = audioFiles[sound_effect]
	sound_effect_player.play()
	
	yield(sound_effect_player, "finished")
	$AudioPlayerContainer.remove_child(sound_effect_player)
