extends Node2D

onready var positions = get_children()
var dir = Vector2.RIGHT

func _input(_event):
	if Input.is_action_pressed('move_up'):
		dir = Vector2.UP
	if Input.is_action_pressed('move_down'):
		dir = Vector2.DOWN
	if Input.is_action_pressed('move_left'):
		dir = Vector2.LEFT
	if Input.is_action_pressed('move_right'):
		dir = Vector2.RIGHT

func get_input_direction():
	return dir
	
#func get_closest_to_mouse():
#	var distances = []
#	for pos in positions:
#		distances.append(get_global_mouse_position().distance_to(pos.global_position))
#	return positions[distances.find(distances.min())].global_position
