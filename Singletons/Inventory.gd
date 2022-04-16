extends Node

var inventory = [
	
]

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

func _unhandled_input(event):
	if event.is_action_pressed("use"):
		print("Teste")

func get_inventory():
	return inventory
