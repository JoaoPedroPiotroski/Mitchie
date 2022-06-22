extends TextureButton

export(String) var volta



func _on_Return_pressed():
	SceneManager.change_level(volta)
