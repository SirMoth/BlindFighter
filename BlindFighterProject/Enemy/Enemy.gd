extends Node2D


onready var animation_player = $AnimationPlayer
onready var audioFiles = {
	"windup": $AudioPlayerContainer/AudioWindup,
	"attack": $AudioPlayerContainer/AudioAttack,
}


func _process(_delta):
	pass


func play_sound_effect(sound_effect : String, location : String = "default") -> void:
	if location != "default":
		match location:
			"left":
				audioFiles[sound_effect].position.x = -960
				audioFiles[sound_effect].volume_db += 3
			"right":
				audioFiles[sound_effect].position.x = 960
				audioFiles[sound_effect].volume_db += 3
			"center":
				audioFiles[sound_effect].position.x = 0
			_:
				print("Location Error")
	
	audioFiles[sound_effect].play()
	
	if location != "default":
		yield(audioFiles[sound_effect], "finished")
		audioFiles[sound_effect].position.x = 0
		audioFiles[sound_effect].volume_db -= 3
