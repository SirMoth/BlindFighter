# Detected by HitBox
class_name HitBox
extends Area2D

export var damage : int = 1


func _init():
	# HurtBox will be collision mask 2 and collision layer 0
	collision_mask = 0
	collision_layer = 2
