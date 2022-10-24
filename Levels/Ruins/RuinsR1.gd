extends Node2D

export(String, FILE) var songfile
var song

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	if not ProjectSettings.get_setting("rendering/2d/options/lights"):
		for light in get_tree().get_nodes_in_group('Lights'):
			light.visible = false
	song = load(songfile)
	AudioManager.play_song(song)
