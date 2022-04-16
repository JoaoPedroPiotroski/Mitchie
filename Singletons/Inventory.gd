extends Node

var inventory = [
	
]

func add_item(item : Item):
	inventory.append(item)
	
func remove_item(item : Item):
	inventory.erase(item)

func _unhandled_input(event):
	if event.is_action_pressed("use"):
		print("Teste")
