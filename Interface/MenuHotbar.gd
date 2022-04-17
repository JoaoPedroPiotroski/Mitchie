extends VBoxContainer

onready var hotbar_slot = preload("res://Interface/Inventory/HotbarSlot/HotbarSlot.tscn")
onready var empty_item = preload("res://Items/Empty.tscn")

func _on_MenuHotbar_visibility_changed():
	for child in get_children():
		child.queue_free()
	for item in Inventory.get_hotbar():
		var slot = hotbar_slot.instance()
		slot.start(item)
		add_child(slot)
