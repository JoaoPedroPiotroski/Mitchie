extends Control

onready var item_detailer = $ItemDetail/Panel
onready var drag_item = preload("res://Interface/Inventory/DragItem.tscn")

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
	visible = get_tree().paused

func show_item_detail(item):
	item_detailer.get_node("Icon").texture = item.icon
	item_detailer.get_node("Title").text = item.name
	item_detailer.get_node("Desc").text = item.description
	item_detailer.get_parent().popup()
