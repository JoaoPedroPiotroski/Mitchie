extends CheckBox

func _ready():
	pressed = Options.lights

func _on_CheckBox_pressed():
	Options.lights = pressed
