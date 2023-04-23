extends Control


var audioFiles = {}
var victory : bool = false
var defeat : bool = false

signal sound_effect_finished

var rng = RandomNumberGenerator.new()


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS # Allows user to navigate menu when game is paused
	audioFiles["player_intro1"] = preload("res://Audio/Sound Effects/player_intro1.wav")
	audioFiles["player_intro2"] = preload("res://Audio/Sound Effects/player_intro2.wav")
	audioFiles["player_intro3"] = preload("res://Audio/Sound Effects/player_intro3.wav")
	audioFiles["player_intro4"] = preload("res://Audio/Sound Effects/player_intro4.wav")
	audioFiles["enemy_intro1"] = preload("res://Audio/Sound Effects/enemy_intro1.wav")
	audioFiles["enemy_intro2"] = preload("res://Audio/Sound Effects/enemy_intro2.wav")
	audioFiles["ready"] = preload("res://Audio/Sound Effects/ready.wav")
	audioFiles["game_start"] = preload("res://Audio/Sound Effects/game_start.wav")
	audioFiles["victory"] = preload("res://Audio/Sound Effects/victory.wav")
	audioFiles["final_hit"] = preload("res://Audio/Sound Effects/player_hit_final.wav")
	audioFiles["enemy_death1"] = preload("res://Audio/Sound Effects/enemy_death1.wav")
	audioFiles["defeat"] = preload("res://Audio/Sound Effects/defeat.wav")
	audioFiles["final_damaged"] = preload("res://Audio/Sound Effects/player_damaged_final.wav")
	
	get_tree().paused = true
#	match (rng.randi() % 2):
#		1:
#			play_sound_effect("enemy_intro1")
#		2:
#			play_sound_effect("enemy_intro2")
#	yield(self, "sound_effect_finished")
#
#	match (rng.randi() % 4):
#		1:
#			play_sound_effect("player_intro1")
#		2:
#			play_sound_effect("player_intro2")
#		3:
#			play_sound_effect("player_intro3")
#		4:
#			play_sound_effect("player_intro4")
#	yield(self, "sound_effect_finished")
#	yield(get_tree().create_timer(0.5), "timeout")
	
	$Ready.visible = true
	play_sound_effect("ready")
	yield(self, "sound_effect_finished")
	yield(get_tree().create_timer(1), "timeout")
	$Ready.visible = false
	$GameBegin.visible = true
	play_sound_effect("game_start")
	yield(self, "sound_effect_finished")
	$GameBegin.visible = false
	get_tree().paused = false


func _physics_process(delta):
	if (victory == true or defeat == true):
		if Input.is_action_just_released("ui_accept"):
			get_tree().change_scene("res://MainMenu/MainMenu.tscn")
			get_tree().paused = false


func _on_Player_player_health_changed(new_health):
	if (new_health <= 0 and victory == false):
		lose()


func _on_Enemy_enemy_health_changed(new_health):
	if (new_health <= 0 and defeat == false):
		win()


func win() -> void:
	victory = true
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().paused = true
	play_sound_effect("final_hit")
	yield(get_tree().create_timer(0.3), "timeout")
	play_sound_effect("enemy_death1")
	yield(get_tree().create_timer(1.5), "timeout")
	$VictoryLabel.visible = true
	play_sound_effect("victory")


func lose() -> void:
	defeat = true
	yield(get_tree().create_timer(0.15), "timeout")
	get_tree().paused = true
	play_sound_effect("final_damaged")
	yield(get_tree().create_timer(0.5), "timeout")
	$DefeatLabel.visible = true
	play_sound_effect("defeat")


func play_sound_effect(sound_effect : String) -> void:
	var sound_effect_player = AudioStreamPlayer2D.new()
	add_child(sound_effect_player)
	sound_effect_player.set_global_position(Vector2(960, 540))
	sound_effect_player.volume_db += 1 # Change to a non-static variable
	sound_effect_player.stream = audioFiles[sound_effect]
	sound_effect_player.play()
	
	yield(sound_effect_player, "finished")
	emit_signal("sound_effect_finished")
	remove_child(sound_effect_player)
