extends Area2D

class_name DragItem

var item : Item

func _ready():
	$Icon.texture = item.icon

func _input(event):
	if event.is_action_released('use'):
		queue_free()
