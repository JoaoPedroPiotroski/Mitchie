extends Node

export(String) var title = '' 
export(String, "Level", "Menu", "Boss", "City") var type
export(Color) var background_color = Color(1, 1, 1)
export(Array, String) var flags

func _ready():
	SceneManager.level['title'] = title
	SceneManager.level['type'] = type
	SceneManager.level['background-color'] = background_color
	SceneManager.level['flags'] = flags
	VisualServer.set_default_clear_color(background_color)
