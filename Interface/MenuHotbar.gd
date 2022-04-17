extends VBoxContainer

onready var hotbar_slot = preload("res://Interface/Inventory/HotbarSlot/HotbarSlot.tscn")

func _ready():
	for i in range(Inventory.get_hotbar_size()):
		var slot = hotbar_slot.instance() 
		add_child(slot)

func _on_MenuHotbar_visibility_changed():
	for item in Inventory.get_hotbar():
		var slot = hotbar_slot.instance()
		slot.start(item)
		add_child(slot)
