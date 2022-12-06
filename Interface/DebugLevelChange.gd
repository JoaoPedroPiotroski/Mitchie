extends TextEdit

func _ready():
	visible = false

func close():
	text = ""
	visible = false
	get_parent().working = false
	get_tree().paused = false
	
func _input(_event):
	if Input.is_key_pressed(KEY_L):
		visible = true
		grab_focus()
		get_parent().working = true
		get_tree().paused = true
		if not visible:
			readonly = true
			yield(get_tree().create_timer(.05), "timeout")
			text = ""
			readonly = false
	if Input.is_key_pressed(KEY_ENTER):
		if text == "togglefps":
			get_parent().get_node("Fps").visible = !get_parent().get_node("Fps").visible
			close()
		if text == 'dindin':
			Inventory.coins += 100
		SceneManager.change_level(text)
		close()
