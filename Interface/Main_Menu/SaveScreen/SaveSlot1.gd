extends TextureButton

export(int) var slot
	
func _on_SaveSlot1_pressed():
	Save.slot = slot
	Save.load_save()	
