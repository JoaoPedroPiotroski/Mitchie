extends TextureButton

export(String) var save_scene
func _ready():
	grab_focus()
	print(':3')

func _on_PlayButton_pressed():
	SceneManager.change_level(save_scene)

