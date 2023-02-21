extends Control


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS # Allows user to navigate menu when game is paused


func _on_Player_player_health_changed(new_health):
	if (new_health <= 0):
		yield(get_tree().create_timer(0.18), "timeout")
		get_tree().paused = true
		$DefeatLabel.visible = true


func _on_Enemy_enemy_health_changed(new_health):
	if (new_health <= 0):
		yield(get_tree().create_timer(0.15), "timeout")
		get_tree().paused = true
		$VictoryLabel.visible = true
