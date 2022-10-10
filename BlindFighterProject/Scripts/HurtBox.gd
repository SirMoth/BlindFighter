# Detects HitBox
class_name HurtBox
extends Area2D


func _init():
	collision_mask = 2
	collision_layer = 0


func _ready():
	connect("area_entered", self, "_on_area_entered")


func _on_area_entered(hitbox: HitBox) -> void:
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
