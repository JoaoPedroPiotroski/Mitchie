extends Node

export var max_hotbar_size : int = 4
onready var empty_item = preload("res://Items/Empty.tscn")

var hotbar = [
	
]

func _ready():
	for i in range(max_hotbar_size):
		hotbar.append(empty_item.instance())

func add_to_hotbar(item : Item, position : int = -1):
	if hotbar.has(item):
		hotbar.erase(item)
	if position != -1:
		hotbar.remove(position)
		hotbar.insert(position, item)

func remove_from_hotbar(item : Item):
	if hotbar.has(item):
		hotbar.erase(item)
