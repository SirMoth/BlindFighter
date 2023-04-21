extends Control

func _process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Levels/TestLevel/TestLevel.tscn")
