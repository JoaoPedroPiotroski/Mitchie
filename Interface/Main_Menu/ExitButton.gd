extends TextureButton




func _on_ExitButton_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_ExitButton_mouse_entered() -> void:
	grab_focus()
