extends VBoxContainer

onready var lights = $Lights/Lights
onready var fullscren = $FullScreen/FullScreen
onready var music = $Music/HSlider
onready var fx = $FX/HSlider

func _ready():
	lights.grab_focus()
	lights.pressed = ProjectSettings.get_setting("rendering/2d/options/lights")
	fullscren.pressed = ProjectSettings.get_setting("display/window/size/fullscreen")
	music.value = db2linear(ProjectSettings.get_setting('audio/music_volume')) * 100
	fx.value = db2linear(ProjectSettings.get_setting('audio/fx_volume')) * 100

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
	var _e = ProjectSettings.save_custom("user://mitchie_settings.godot")


func _on_music_drag_ended(_value_changed):
	ProjectSettings.set_setting('audio/music_volume', linear2db(music.value / 100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Music'), ProjectSettings.get_setting('audio/music_volume'))

func _on_fx_drag_ended(_value_changed):
	ProjectSettings.set_setting('audio/fx_volume', linear2db(fx.value / 100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Effects'), ProjectSettings.get_setting('audio/fx_volume'))
