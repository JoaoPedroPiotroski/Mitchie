extends Node

export var max_hotbar_size : int = 4
onready var empty_item = preload("res://Items/Empty.tscn")

signal hotbar_changed

var hotbar = [
	
]

func _ready():
	for i in range(max_hotbar_size):
		hotbar.append(empty_item.instance())

func add_to_hotbar(item : Item, position, origin=0):
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
	
func remove_from_hotbar(item : Item):
	if hotbar.has(item):
		hotbar.insert(hotbar.find(item), empty_item.instance())
		hotbar.erase(item)
	emit_signal("hotbar_changed")
