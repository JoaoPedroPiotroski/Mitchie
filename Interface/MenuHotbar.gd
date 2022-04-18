extends VBoxContainer

onready var hotbar_slot = preload("res://Interface/Inventory/HotbarSlot/HotbarSlot.tscn")
onready var empty_item = preload("res://Items/Empty.tscn")
var slots = []
	
func _ready():
	Inventory.get_node("Hotbar").connect('hotbar_changed', self, 'on_hotbar_changed')
	
	
func on_hotbar_changed():
	update_hotbar_display()

func update_hotbar_display():
	for child in get_children():
		child.queue_free()
	var i = 0
	for item in Inventory.get_hotbar():
		var slot = hotbar_slot.instance()
		slot.start(item, i)
		add_child(slot)
		i += 1
	slots = get_children()


func _on_MenuHotbar_visibility_changed():
	update_hotbar_display()

