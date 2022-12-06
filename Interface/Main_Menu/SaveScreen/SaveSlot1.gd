extends TextureButton

export(int) var slot
	
func _on_SaveSlot1_pressed():
	print('tentenandocarregar')
	Save.slot = slot
	Save.load_save()	


func _on_Delete_pressed() -> void:
	Save.slot = slot
	Save.delete_save()
