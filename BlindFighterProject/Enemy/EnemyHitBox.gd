extends HitBox


onready var collision = $CollisionShape2D

enum Location {LEFT, RIGHT, CENTER, LEFT_CENTER, RIGHT_CENTER, ALL}


func _physics_process(delta):
	if monitorable == false:
		if collision.self_modulate != Color(1, 0, 0, 0):
			collision.self_modulate = Color(1, 0, 0, 0)
	else:
		if collision.self_modulate != Color(1, 0, 0, 0.7):
			collision.self_modulate = Color(1, 0, 0, 0.7)


func set_location(location):
	match location:
		Location.LEFT:
			if collision.position != Vector2(704, 778):
				collision.position = Vector2(960, 778)
			if collision.scale.x != 1:
				collision.scale.x = 1
		Location.RIGHT:
			if collision.position != Vector2(1216, 778):
				collision.position = Vector2(960, 778)
			if collision.scale.x != 1:
				collision.scale.x = 1
		Location.CENTER:
			if collision.position != Vector2(960, 778):
				collision.position = Vector2(960, 778)
			if collision.scale.x != 1:
				collision.scale.x = 1
		Location.LEFT_CENTER:
			if collision.position != Vector2(832, 778):
				collision.position = Vector2(960, 778)
			if collision.scale.x != 1:
				collision.scale.x = 1
		Location.RIGHT_CENTER:
			if collision.position != Vector2(1088, 778):
				collision.position = Vector2(960, 778)
			if collision.scale.x != 1:
				collision.scale.x = 1
		Location.ALL:
			if collision.position != Vector2(960, 778):
				collision.position = Vector2(960, 778)
			if collision.scale.x != 3:
				collision.scale.x = 3
