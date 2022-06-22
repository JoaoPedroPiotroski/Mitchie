extends VBoxContainer


func _input(event):
	if Input.is_action_just_pressed('ui_down'):
		$SaveSlot1.grab_focus()
