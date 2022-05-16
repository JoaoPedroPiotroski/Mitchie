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

signal item_added(item)
signal item_removed(item)

func add_item(item : Item):
	print(item)
	if !is_item_in_inventory(item):
		inventory.append(item)
		return
	if item.stackable:
		pass
		return
	var itemdrop = load("res://Items/Drop/ItemDrop.tscn")
	var reject = itemdrop.instance()
	var scene = PackedScene.new()
	scene.pack(item)
	reject.setup(scene, 0)
	reject.global_position = Global.player.global_position
	Global.current_level.add_child(reject)

func is_item_in_inventory(item):
	for i in inventory:
		if i.name == item.name:
			return true
	return false
	
func remove_item(item : Item):
	inventory.erase(item)

func get_inventory():
	return inventory

func get_hotbar():
	return hotbar.hotbar

func get_hotbar_size():
	return hotbar.hotbar.size()
