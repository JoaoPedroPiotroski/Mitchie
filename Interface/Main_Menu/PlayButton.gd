extends TextureButton

export(String) var save_scene
func _ready():
	grab_focus()
	AudioManager.play_song(load("res://Music/Audio/mainmenu.ogg"))

func _on_PlayButton_pressed():
	SceneManager.change_level(save_scene)

