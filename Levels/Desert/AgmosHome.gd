extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VisualServer.set_default_clear_color(Color(0.1, 0.1, 0.1))
	AudioManager.play_song("res://Music/Audio/city.ogg")