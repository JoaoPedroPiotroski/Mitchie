extends Node

var existing_items = []

signal inventory_changed

func _ready():
	update_existing_items()
	add_item_by_title('Foice', 1)
	
func add_item_by_title(title : String, amount : int) -> void:
	emit_signal("inventory_changed")
	for i in existing_items:
		if i.title == title:
			i.amount += amount
	
func add_item_by_resource(i : Resource, amount : int) -> void:
	emit_signal("inventory_changed")
	i.amount += amount
	
func remove_item(i : Resource, amount: int) -> void:
	emit_signal("inventory_changed")
	i.amount -= amount
	i.amount = max(0, i.amount	)
	
func has_item(name):
	for i in existing_items:
		if i.title == name and i.amount >= 1:
			return true
	return false
	
func get_inventory() -> Array:  
	var inv = []
	for i in existing_items:
		if i.amount > 0:
			 inv.append(i)
	return inv

func update_existing_items() -> void:
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
