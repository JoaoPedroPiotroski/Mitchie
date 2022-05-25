extends Node

var existing_items = []

func _ready():
	update_existing_items()
	
func add_item(i : Resource, amount : int) -> void:
	i.amount += amount
	
func remove_item(i : Resource, amount: int) -> void:
	i.amount -= amount
	i.amount = max(0, i.amount	)
	
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
