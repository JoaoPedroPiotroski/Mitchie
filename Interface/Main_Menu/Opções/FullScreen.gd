extends CheckBox


func _ready():
	pressed = Options.fullscreen

func _on_CheckBox_pressed():
	Options.fullscreen = pressed
