extends VBoxContainer

onready var music = $Music/HSlider
onready var fx = $FX/HSlider

func _ready():
	music.value = db2linear(ProjectSettings.get_setting('audio/music_volume')) * 100
	fx.value = db2linear(ProjectSettings.get_setting('audio/fx_volume')) * 100


func _on_music_drag_ended(_value_changed):
	ProjectSettings.set_setting('audio/music_volume', linear2db(music.value / 100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Music'), ProjectSettings.get_setting('audio/music_volume'))

func _on_fx_drag_ended(_value_changed):
	ProjectSettings.set_setting('audio/fx_volume', linear2db(fx.value / 100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Effects'), ProjectSettings.get_setting('audio/fx_volume'))
