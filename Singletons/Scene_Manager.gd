extends Node
	 
var level = {
	'title' : 'default',
	'type' : 'Level',
	'background-color' : Color(0.5,0.5,0.5),
	'flags' : []
}   

func change_level(new_level):
	get_tree().change_scene_to(new_level)
