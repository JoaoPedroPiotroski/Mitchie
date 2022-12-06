extends CanvasLayer

var data : Resource 

onready var item_list = $Control/Panel/Scroll/ItemList

var item_slot_scene = "res://Interface/Shop/shop_item.tscn"

func start(_shop : Resource):
	data = _shop

func _ready() -> void:
	get_tree().paused = true
	data = load("res://Interface/Shop/Resources/rose_shop.tres")
	$Control/Panel/ShopName.text = data.shop_name
	for key in data.items:
		var value = data.items[key]
		var _itemslot = load(item_slot_scene)
		var itemslot = _itemslot.instance()
		itemslot.start(key, value)
		item_list.add_child(itemslot)
	item_list.get_child(0).grab_focus()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('move_right'):
		$Control/Panel/Exit.grab_focus()
	if event.is_action_pressed('move_left'):
		item_list.get_child(0).grab_focus()
	if Input.is_action_just_pressed('pause'):
		_on_Exit_pressed()


func _on_Exit_pressed() -> void:
	get_tree().paused = false
	queue_free()
