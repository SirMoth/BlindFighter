extends Control


var audioFiles = {}


func _ready():
	audioFiles["blind_fighter"] = preload("res://Audio/Sound Effects/main_menu.wav")
	
	play_sound_effect("blind_fighter")


func _process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Levels/TestLevel/TestLevel.tscn")


func play_sound_effect(sound_effect : String) -> void:
	var sound_effect_player = AudioStreamPlayer2D.new()
	sound_effect_player.set_global_position(Vector2(960, 540))
	add_child(sound_effect_player)
	sound_effect_player.volume_db += 1 # Change to a non-static variable
	sound_effect_player.stream = audioFiles[sound_effect]
	sound_effect_player.play()
	
	yield(sound_effect_player, "finished")
	remove_child(sound_effect_player)
