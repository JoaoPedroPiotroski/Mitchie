extends TextureButton

export(String, FILE) var volta



func _on_Return_pressed():
	SceneManager.change_level(load(volta))
