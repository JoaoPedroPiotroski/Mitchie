extends Node

export var max_hotbar_size : int = 4

var selected_item = 0
onready var empty_item = preload("res://Items/Resources/Empty.tres")

signal hotbar_changed
signal selected_item_changed(item)

var hotbar = [
	
]

func select_item(num):
	selected_item = num
	emit_signal("selected_item_changed", get_selected_item())
	
func _input(event):
	if event.is_action_pressed('numerical'):
		var press = event.as_text()
		var num = int(press)
		if num <= 3:
			select_item(num-1)
			emit_signal("hotbar_changed")

func get_selected_item():
	return hotbar[selected_item]

func _ready():
	for i in range(max_hotbar_size):
		hotbar.append(empty_item)
	select_item(0)
	emit_signal("selected_item_changed", get_selected_item())

func add_to_hotbar(item : Resource, position, origin=0):
	if hotbar.has(item) and item.name != "Empty": 
		hotbar.insert(hotbar.find(item), empty_item.instance())
		hotbar.erase(item)
		hotbar.remove(position)
		hotbar.insert(position, item)
	elif hotbar.has(item) and item.name == "Empty":
		var olditem = hotbar[position]
		
		hotbar.insert(origin, olditem)
		hotbar.remove(origin+1)
		
		hotbar.insert(position, item)
		hotbar.remove(position+1)
	else:
		hotbar.remove(position)
		hotbar.insert(position, item)
	emit_signal("hotbar_changed")
	emit_signal("selected_item_changed", get_selected_item())
	
func remove_from_hotbar(item : Resource):
	if hotbar.has(item):
		hotbar.insert(hotbar.find(item), empty_item.instance())
		hotbar.erase(item)
	emit_signal("hotbar_changed")
	emit_signal("selected_item_changed", get_selected_item())
