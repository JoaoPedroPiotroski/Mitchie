extends GridContainer

onready var item_slot = preload("res://Interface/Inventory/ItemSlot/ItemSlot.tscn")

func update():
	for child in get_children():
		child.queue_free()
	var inventory = Inventory.get_inventory()
	for item in inventory:
		if item.type != item.types.milestone:
			var slot = item_slot.instance()
			slot.start(item)
			add_child(slot)
			var _c = slot.connect('clicked', self, 'item_clicked')

	
func _ready():
	update()
	
func _on_ItemsGrid_visibility_changed():
	update()


func _on_ItemsGrid_focus_entered() -> void:
	if get_child_count() > 0:
		get_child(0).grab_focus()

func item_clicked():
	yield(get_tree().create_timer(0.1), 'timeout')
	
	if get_child_count() > 0:
		get_child(0).grab_focus()
