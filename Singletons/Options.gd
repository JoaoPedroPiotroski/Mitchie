extends Node

func set_fullscreen(new_val):
	ProjectSettings.set_setting("display/window/size/fullscreen", new_val)
	var _e = ProjectSettings.save_custom("Settings")