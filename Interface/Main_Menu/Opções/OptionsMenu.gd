extends VBoxContainer

onready var lights = $Lights/Lights
onready var fullscren = $FullScreen/FullScreen

func _ready():
	lights.pressed = ProjectSettings.get_setting("rendering/2d/options/lights")
	fullscren.pressed = ProjectSettings.get_setting("display/window/size/fullscreen")

func _on_Lights_pressed():
	ProjectSettings.set_setting("rendering/2d/options/lights", lights.pressed)

func _on_FullScreen_pressed():
	ProjectSettings.set_setting("display/window/size/fullscreen", fullscren.pressed)

func _on_SaveSettings_pressed():
	var was_full = OS.window_fullscreen 
	OS.window_fullscreen = fullscren.pressed
	if !fullscren.pressed and was_full:
		OS.window_size = Vector2(ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height"))
		OS.window_position = OS.get_screen_size() / 2 - OS.window_size / 2
	var e = ProjectSettings.save_custom("user://mitchie_settings.godot")
	print(e)
