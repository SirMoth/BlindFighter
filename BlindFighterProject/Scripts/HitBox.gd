# Detected by HitBox
class_name HitBox
extends Area2D

export var damage : int = 1


func _init():
	# Hitbox is off when initialized
	monitorable = false
	# HurtBox will be collision mask 2 and collision layer 0
	collision_mask = 0
	collision_layer = 2


# If duration is negative, the attack lasts infinitely.
func activate(duration = -1, attack_damage: int = 1, delay = 0) -> void:
	if delay > 0:
		yield(get_tree().create_timer(delay), "timeout")
	damage = attack_damage
	monitorable = true
	if duration >= 0:
		yield(get_tree().create_timer(duration), "timeout")
		deactivate()


func deactivate() -> void:
	damage = 1
	monitorable = false
