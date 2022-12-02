extends Node


signal attack_left
signal attack_right
signal attack_center

# Variable that increases as the fight goes on, making attack patterns harder.
var escalation : int = 0
# Variable to count how many attacks the enemy has made in a row.
var combo : int = 0


func _ready():
	yield(get_tree().create_timer(2), "timeout")
	attack_random_side()
	yield($"%StateMachine", "attack_finished")
	escalation += 1


func _physics_process(delta):
	if (combo <= escalation) or (combo <= 6 and escalation >= 6):
		# Matches escalation to determine attack pattern to use.
		match escalation:
			0:
				attack_random_side()
			1:
				attack_random()
			2, 3, 4, 5:
				if combo == escalation:
					attack_center()
				else:
					attack_random_side()
			_:
				if combo == 6:
					attack_center()
				else:
					attack_random()
		yield($"%StateMachine", "attack_finished")
		combo += 1
	# Resets the combo, increases escalation, and gives a window to be attacked after full attack pattern.
	if (combo > escalation) or (combo > 6):
		combo = 0
		escalation += 1
		yield(get_tree().create_timer(1), "timeout")


# Functions to emit attack signals to the State Machine
func attack_left(number_of_attacks = 1):
	for i in range(number_of_attacks):
		emit_signal("attack_left")

func attack_right(number_of_attacks = 1):
	for i in range(number_of_attacks):
		emit_signal("attack_right")

func attack_center(number_of_attacks = 1):
	for i in range(number_of_attacks):
		emit_signal("attack_left")

func attack_random(number_of_attacks = 1):
	match (randi() % 3):
		0:
			emit_signal("attack_left")
		1:
			emit_signal("attack_right")
		2:
			emit_signal("attack_center")
		_:
			print("Random attack error: Out of scope")

func attack_random_side(number_of_attacks = 1):
	match (randi() % 2):
		0:
			emit_signal("attack_left")
		1:
			emit_signal("attack_right")
		_:
			print("Random attack error: Out of scope")
