extends Node
	
var level : Resource = load("res://Levels/Resources/MainMenu.tres")
var entrance = 0

func _ready():
	var _c = get_tree().connect("node_added", self, 'level_loading_procedures')

func change_level(new_level : String):
	var dir = Directory.new()
	var path = "res://Levels/Resources/"
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				if load(path+file_name).title == new_level:
					var l = load(path+file_name)
					var s = load(l.scene_path)
					var _e = get_tree().change_scene_to(s)
					level = l
					VisualServer.set_default_clear_color(level.background_color)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func level_loading_procedures(_n):
	if not ProjectSettings.get_setting("rendering/2d/options/lights"):
		for light in get_tree().get_nodes_in_group('Lights'):
			light.enabled = false
