extends GridContainer

onready var item_slot = preload("res://Interface/Inventory/ItemSlot/ItemSlot.tscn")

func update():
	for child in get_children():
		child.queue_free()
	var inventory = Inventory.get_inventory()
	for item in inventory:
		var slot = item_slot.instance()
		slot.start(item)
		add_child(slot)

	
func _ready():
	update()
	


func _on_ItemsGrid_visibility_changed():
	update()
