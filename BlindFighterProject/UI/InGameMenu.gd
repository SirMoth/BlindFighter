extends Control


var audioFiles = {}
var victory : bool = false
var defeat : bool = false


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS # Allows user to navigate menu when game is paused
	audioFiles["game_start"] = preload("res://Audio/Sound Effects/game_start.wav")
	audioFiles["victory"] = preload("res://Audio/Sound Effects/victory.wav")
	audioFiles["defeat"] = preload("res://Audio/Sound Effects/defeat.wav")
	#get_tree().paused = true
	#$GameBegin.visible = true
	#play_sound_effect("game_start")


func _physics_process(delta):
	if $GameBegin.visible == true:
		if Input.is_action_just_released("ui_accept"):
			$GameBegin.visible = false
			get_tree().paused = false
	if (victory == true or defeat == true):
		if Input.is_action_just_released("ui_accept"):
			get_tree().reload_current_scene()


func _on_Player_player_health_changed(new_health):
	if (new_health <= 0 and victory == false):
		lose()


func _on_Enemy_enemy_health_changed(new_health):
	if (new_health <= 0 and defeat == false):
		win()


func win() -> void:
	victory = true
	yield(get_tree().create_timer(0.15), "timeout")
	get_tree().paused = true
	$VictoryLabel.visible = true
	play_sound_effect("victory")


func lose() -> void:
	defeat = true
	yield(get_tree().create_timer(0.18), "timeout")
	get_tree().paused = true
	$DefeatLabel.visible = true
	play_sound_effect("defeat")


func play_sound_effect(sound_effect : String) -> void:
	var sound_effect_player = AudioStreamPlayer2D.new()
	add_child(sound_effect_player)
	sound_effect_player.volume_db += 1 # Change to a non-static variable
	sound_effect_player.stream = audioFiles[sound_effect]
	sound_effect_player.play()
	
	yield(sound_effect_player, "finished")
	remove_child(sound_effect_player)
