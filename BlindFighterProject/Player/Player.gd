extends Node2D


var starting_position : Vector2

onready var animation_player = $AnimationPlayer


func _ready():
	starting_position = global_position


func _process(_delta):
	pass

