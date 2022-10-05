extends Node2D


var starting_position : Vector2
var dodge_distance : int = 400

onready var animation_player = $AnimationPlayer


func _ready():
	starting_position = $SpriteContainer.get_position()


func _process(_delta):
	pass


func move(location : String = "start") -> void:
	match location:
		"left":
			var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property($SpriteContainer, "position", Vector2(starting_position.x - dodge_distance, starting_position.y), animation_player.current_animation_length)
		"right":
			var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property($SpriteContainer, "position", Vector2(starting_position.x + dodge_distance, starting_position.y), animation_player.current_animation_length)
		"start":
			var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property($SpriteContainer, "position", starting_position, animation_player.current_animation_length)
		_:
			print("Error: Incorrect location given for move() function")
			
