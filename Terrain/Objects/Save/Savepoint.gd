extends Area2D

class_name savepoint
export var entrance = 0

func _ready():
	add_to_group('savepoints')
	add_to_group('doors')
	
func show_hint():
	$door_hint.visible = true
	
func hide_hint():
	$door_hint.visible = false
