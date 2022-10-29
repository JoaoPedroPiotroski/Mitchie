extends TextureButton

var song = preload("res://Music/Audio/mainmenu.ogg")

export(String) var save_scene
func _ready():
	grab_focus()
	AudioManager.play_song(song, 6000)

func _on_PlayButton_pressed():
	SceneManager.change_level(save_scene)
