extends Resource
class_name LevelData

export(String) var title = '' 
export(String, "Level", "Menu", "Boss", "City") var type
export(Color) var background_color = Color(1, 1, 1)
export(Array, String) var flags
export(String, FILE) var scene_path
