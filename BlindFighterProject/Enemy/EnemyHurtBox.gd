extends Area2D


onready var collision = $CollisionShape2D

enum Condition {IDLE, PARRY, INVINCIBLE}
var current_condition
var color = {
	"idle": Color(0, 1, 0, 0.7),
	"parry": Color(0, 0, 1, 0.7),
	"invincible": Color(0, 0, 0, 0.7),
	"hit": Color(1, 0, 0, 0.7),
}

signal parried


func _ready():
	set_status(Condition.IDLE, color["idle"])


func _on_area_entered(hitbox: HitBox) -> void:
	match current_condition:
		Condition.IDLE:
			if owner.has_method("take_damage"):
				owner.take_damage(hitbox.damage)
		Condition.PARRY:
			emit_signal("parried")
		Condition.INVINCIBLE:
			pass


func set_status(condition, color: Color):
	if current_condition != condition:
		current_condition = condition
	if collision.self_modulate != color:
		collision.self_modulate = color
