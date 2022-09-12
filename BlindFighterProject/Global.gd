extends Node

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"): #This is a hard escape input for testing. Remove when a menu is created.
		get_tree().quit()
