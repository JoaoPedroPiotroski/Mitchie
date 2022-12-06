extends TextureButton

export(String) var save_scene
func _on_OptionsButton_pressed():
	SceneManager.change_level(save_scene)



func _on_OptionsButton_mouse_entered() -> void:
	grab_focus()
