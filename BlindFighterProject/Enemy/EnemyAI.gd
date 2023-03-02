extends Node


signal attack_left
signal attack_right
signal attack_center

# Variable that increases as the fight goes on, making attack patterns harder.
var escalation : int = 0
# Variable to count how many attacks the enemy has made in a row.
var combo : int = 0


func _ready():
	yield(get_tree().create_timer(2.5), "timeout")
	next_attack()


# Functions to emit attack signals to the State Machine
func attack_left():
	emit_signal("attack_left")

func attack_right():
	emit_signal("attack_right")

func attack_center():
	emit_signal("attack_center")

func attack_random():
	match (randi() % 3):
		0:
			emit_signal("attack_left")
		1:
			emit_signal("attack_right")
		2:
			emit_signal("attack_center")
		_:
			print("Random attack error: Out of scope")

func attack_random_side():
	match (randi() % 2):
		0:
			emit_signal("attack_left")
		1:
			emit_signal("attack_right")
		_:
			print("Random attack error: Out of scope")


func next_attack():
	if (combo <= escalation) or (combo <= 5 and escalation >= 5):
		combo += 1
		# Matches escalation to determine attack pattern to use.
		match escalation:
			0:
				attack_random_side()
			1:
				attack_random()
			2, 3, 4:
				if combo == escalation:
					attack_center()
				else:
					attack_random_side()
			5:
				if combo == escalation:
					attack_center()
				else:
					attack_random()
			_:
				if combo == 5:
					attack_center()
				else:
					attack_random()
		yield(get_tree().create_timer(0.3), "timeout")
	# Resets the combo, increases escalation, and gives a window to be attacked after full attack pattern.
	if (combo >= escalation) or (combo >= 5):
		combo = 0
		escalation += 1


func _on_StateMachine_attack_finished():
	if combo == 0:
		yield(get_tree().create_timer(1.5), "timeout")
	next_attack()
