extends VBoxContainer

var slots = []
onready var hotbar_slot = preload("res://Interface/Inventory/HotbarSlot/HotbarSlot.tscn")

func _ready():
	Inventory.get_node("Hotbar").connect('hotbar_changed', self, 'on_hotbar_changed')
	Menu.get_node("PauseMenu").connect('game_pause_changed', self, 'on_pause_changed')
	update_hotbar_display()


		

func update_hotbar_display():
	for child in get_children():
		child.queue_free()
	var i = 0
	for item in Inventory.get_hotbar():
		var slot = hotbar_slot.instance()
		slot.start(item, i, false)
		add_child(slot)
		i += 1
	slots = get_children()

func on_hotbar_changed():
	update_hotbar_display()

func on_pause_changed():
	update_hotbar_display()
