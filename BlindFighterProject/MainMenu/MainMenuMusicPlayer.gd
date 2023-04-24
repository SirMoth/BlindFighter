extends AudioStreamPlayer


var is_playing_intro : bool = true
var chorus


func _ready() -> void:
	connect("finished", self, "_on_finished")
	chorus = preload("res://Audio/Music/SE_Chorus.wav")

func _on_finished() -> void:
	if is_playing_intro == true:
		set_stream(chorus)
		play()
		is_playing_intro = false
