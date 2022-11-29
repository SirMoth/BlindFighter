extends HitBox


onready var collision = $CollisionShape2D


func _physics_process(delta):
	if monitorable == false:
		if collision.self_modulate != Color(1, 0, 0, 0):
			collision.self_modulate = Color(1, 0, 0, 0)
	else:
		if collision.self_modulate != Color(1, 0, 0, 0.7):
			collision.self_modulate = Color(1, 0, 0, 0.7)
