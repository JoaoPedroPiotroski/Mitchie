extends GridContainer

onready var item_slot = preload("res://Interface/Inventory/ItemSlot/ItemSlot.tscn")

func _ready():
	var inventory = Inventory.get_inventory()
	for item in inventory:
		var slot = item_slot.instance()
		slot.start(item)
		add_child(slot)
