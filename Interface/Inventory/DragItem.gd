extends Area2D

class_name DragItem

var item : Resource
var holding = true

func _ready():
	$Icon.texture = item.icon

func start(in_item):
	$Icon.texture = in_item.icon
	item = in_item
	
func _process(delta):
	if holding:
		global_position = get_global_mouse_position()
	else:
		queue_free()

func _input(event):
	if event.is_action_released('use'):
		$Expire.start()
		holding = false


func _on_Expire_timeout():
	queue_free()
