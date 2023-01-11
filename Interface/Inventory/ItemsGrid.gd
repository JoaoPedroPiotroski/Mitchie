extends GridContainer

onready var item_slot = preload("res://Interface/Inventory/ItemSlot/ItemSlot.tscn")
var selected_item : String = "" setget set_selected_item, get_selected_item

func update():
	set_selected_item('')
	for child in get_children():
		child.queue_free()
	var inventory = Inventory.get_inventory()
	for item in inventory:
		if item.type != item.types.milestone:
			var slot = item_slot.instance()
			slot.start(item)
			add_child(slot)
			var _c = slot.connect('clicked', self, 'item_clicked')
			_c = slot.connect('item_selected', self, 'set_selected_item')

	
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

func set_selected_item(new_item) -> void:
	var item_detail = get_parent().get_node("ItemDetail")
	if new_item == '':
		item_detail.visible = false
		item_detail.get_node("name").text = ''
		item_detail.get_node("desc").text = ''
		return
	item_detail.visible = true
	var item_resource = Inventory.get_item(new_item)
	item_detail.get_node("name").text = item_resource.display_title.capitalize() 
	item_detail.get_node("desc").text = item_resource.description
	item_detail.get_node("amt").text = String(item_resource.amount)
	selected_item = new_item
	
func get_selected_item() -> String:
	return selected_item
