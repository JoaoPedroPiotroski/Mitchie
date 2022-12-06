extends Node
	
var level : Resource = load("res://Levels/Resources/MainMenu.tres")
var entrance = 0 setget set_entrance
var s
var loading = false
func _ready():
	Menu.connect('transition_ended', self, 'on_transition_ended')

func set_entrance(_entrance):
	entrance = int(_entrance)

func on_transition_ended():
	if loading:
		var _e = get_tree().change_scene_to(s)
		loading = false
		if _e == 0:
			Menu.transition_end()

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
					s = load(l.scene_path)
					loading = true
					Menu.transition_start()
					#var _e = get_tree().change_scene_to(s)
					level = l
					VisualServer.set_default_clear_color(level.background_color)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
