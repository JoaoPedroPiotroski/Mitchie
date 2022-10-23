extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String, FILE) var songfile
var song


# Called when the node enters the scene tree for the first time.
func _ready():
	if not ProjectSettings.get_setting("rendering/2d/options/lights"):
		for light in get_tree().get_nodes_in_group('Lights'):
			light.enabled = false
	song = load(songfile)
	AudioManager.play_song(song)
