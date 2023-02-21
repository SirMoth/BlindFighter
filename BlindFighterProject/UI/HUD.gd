extends Control


func _on_Player_player_health_changed(new_health):
	$PlayerLifeContainer/LifeTotal.set_text(str(new_health))
