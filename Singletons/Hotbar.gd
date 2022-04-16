extends Node

export var max_hotbar_size : int = 5

var hotbar = [
	
]

func add_to_hotbar(item : Item, position : int = -1):
	if hotbar.has(item):
		hotbar.erase(item)
	if position != -1:
		hotbar.insert(position, item)
	else:
		hotbar.append(item)

func remove_from_hotbar(item : Item):
	if hotbar.has(item):
		hotbar.erase(item)
