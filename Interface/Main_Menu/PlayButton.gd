extends TextureButton

export(PackedScene) var save_scene

func _on_PlayButton_pressed():
	SceneManager.change_level(save_scene)
