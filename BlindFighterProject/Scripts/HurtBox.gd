# Detects HitBox
class_name HurtBox
extends Area2D


func _init():
	# The hurtbox detects hits but does not deal them
	monitoring = true
	monitorable = false
	# Collision mask/layer 2 is for hitboxes and hurtboxes
	collision_mask = 2


func _ready():
	connect("area_entered", self, "_on_area_entered")


func _on_area_entered(hitbox: HitBox) -> void:
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
