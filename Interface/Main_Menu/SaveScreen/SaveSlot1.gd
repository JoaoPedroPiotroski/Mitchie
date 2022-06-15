extends TextureButton

export(String, FILE) var slot1 


func _on_SaveSlot1_pressed():
	SceneManager.change_level(load(slot1))
