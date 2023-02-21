extends Control


func _on_Player_player_health_changed(new_health):
	$PlayerLifeContainer/LifeTotal.set_text(str(new_health))


func _on_Enemy_enemy_health_changed(new_health):
	$EnemyLifeContainer/LifeTotal.set_text(str(new_health))
