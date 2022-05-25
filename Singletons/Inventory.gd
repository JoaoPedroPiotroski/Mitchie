extends Node

var inventory = [
	
]

var existing_items = [
	
]

onready var hotbar = $Hotbar

func _ready():
	var dir = Directory.new()
	var path = "res://Items/Resources/"
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				existing_items.append(load(path+file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
func switch_item(item1, item2):
	var pos1 = inventory.find(item1)
	var pos2 = inventory.find(item2) 
	remove_item(item1)
	remove_item(item2)
	inventory.insert(pos1, item2) 
	inventory.insert(pos2, item1)

signal item_added(item)
signal item_removed(item)


func add_item(item : Resource):
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
	
func remove_item(item : Resource):
	inventory.erase(item)

func get_inventory():
	return inventory

func get_hotbar():
	return hotbar.hotbar

func get_hotbar_size():
	return hotbar.hotbar.size()
