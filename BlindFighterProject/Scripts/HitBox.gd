# Detected by HitBox
class_name HitBox
extends Area2D


export var damage : int = 1


func _init():
	# Hitbox is off when initialized
	monitorable = false
	# Hitbox should never detect being hit
	monitoring = false
	# Collision mask/layer 2 is for hitboxes and hurtboxes
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
