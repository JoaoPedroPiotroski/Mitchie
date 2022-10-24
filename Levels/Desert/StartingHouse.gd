extends Node2D

func _ready():
	VisualServer.set_default_clear_color(Color('#d5ebe8'))
	AudioManager.play_song(load("res://Music/Audio/city.ogg"))
