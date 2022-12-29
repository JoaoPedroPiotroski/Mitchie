extends Node

var existing_items = []
var coins = 0

signal inventory_changed
signal item_removed(item_name, amount)
signal item_added(item_name, amount)

func _ready():
	update_existing_items()
	#Save.connect('game_loaded', self, 'load_inventory')
	add_item_by_title('Foice', 1)
	add_item_by_title('Coin', 0)
	
func get_item(title : String):
	for i in existing_items:
		if i.title == title:
			return i
			
func load_inventory():
	coins = Save.coins
	print(Save.inventory)
	for i in existing_items:
		i.amount = 0
	for k in Save.inventory.keys():
		add_item_by_title(k, Save.inventory[k])
	
func add_item_by_title(title : String, amount) -> void:
	amount = int(amount)
	emit_signal("inventory_changed")
	for i in existing_items:
		if i.title == title:
			i.amount += amount
			emit_signal("item_added", i, amount)
	
func add_item_by_resource(i : Resource, amount : int) -> void:
	emit_signal("inventory_changed")
	i.amount += amount
	
func remove_item(i : Resource, amount: int) -> void:
	amount = int(amount)
	emit_signal("inventory_changed")
	i.amount -= amount
	i.amount = max(0, i.amount	)
	emit_signal("item_removed", i, amount)
	
func remove_item_by_title(t : String, amount) -> void:
	amount = int(amount)
	emit_signal("inventory_changed")
	for i in existing_items:
		if i.title == t:
			i.amount -= amount
			i.amount = max(0, i.amount)
	emit_signal("item_removed", get_item(t), amount)
	
func has_item(_name):
	for i in existing_items:
		if i.title == _name and i.amount >= 1:
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
