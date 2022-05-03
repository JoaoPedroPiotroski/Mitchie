extends Node

var inventory = [
	
]

onready var hotbar = $Hotbar

func switch_item(item1, item2):
	var pos1 = inventory.find(item1)
	var pos2 = inventory.find(item2) 
	remove_item(item1)
	remove_item(item2)
	inventory.insert(pos1, item2) 
	inventory.insert(pos2, item1)

func _ready():
	var i = load("res://Items/FireBullet/FireBullet.tscn")
	var b = i.instance()
	add_item(b)

signal item_added(item)
signal item_removed(item)

func add_item(item : Item):
	inventory.append(item)
	
func remove_item(item : Item):
	inventory.erase(item)

func _input(event):
	if event.is_action_pressed("use"):
		print(hotbar.hotbar)
		print(hotbar.selected_item)
		hotbar.get_selected_item()._use()

func get_inventory():
	return inventory

func get_hotbar():
	return hotbar.hotbar

func get_hotbar_size():
	return hotbar.hotbar.size()
