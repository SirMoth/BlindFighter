extends Node2D


var starting_position : Vector2
var dodge_distance : int = 300

onready var animation_player = $AnimationPlayer


func _ready():
	starting_position = global_position


func _process(_delta):
	pass


func move(location : String = "start") -> void:
	match location:
		"left":
			var tween := create_tween()
			tween.tween_property(self, "global_position.x", starting_position.x - dodge_distance, animation_player.current_animation_length)
		"right":
			var tween := create_tween()
			tween.tween_property(self, "global_position.x", starting_position.x + dodge_distance, animation_player.current_animation_length)
		"start":
			var tween := create_tween()
			tween.tween_property(self, "global_position", starting_position, animation_player.current_animation_length)
		_:
			print("Error: Incorrect location given for move() function")
			
