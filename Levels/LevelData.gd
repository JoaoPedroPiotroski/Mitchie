extends Resource
class_name LevelData

export(String) var title = '' 
export(String, "Level", "Menu", "Boss", "City") var type
export(Color) var background_color = Color(1, 1, 1)
export(Array, String) var flags
export(String, FILE) var scene_path
export(int) var cam_limit_L = -1000000
export(int) var cam_limit_T = -1000000
export(int) var cam_limit_B = 1000000
export(int) var cam_limit_R = 1000000
export(Vector2) var cam_zoom = Vector2(0.8, 0.8)
export(Color) var dust_color = Color.white
export(int) var dustyness = 8
export(bool) var camera_smoothing = false
export(int) var camera_smoothness = 0
