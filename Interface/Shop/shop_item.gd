extends TextureButton

var item_name := ''
var price := 0

func start(_item_name, _price) -> void:
	item_name = _item_name
	price = _price

func _ready() -> void:
	$price.text = String(price)
	texture_normal = Inventory.get_item(item_name).icon
	texture_focused = Inventory.get_item(item_name).icon


func _on_shop_item_pressed() -> void:
	if Inventory.coins >= price:
		if Inventory.get_item(item_name).stackable:
			Inventory.add_item_by_title(item_name, 1)
			Inventory.coins -= price
		else:
			if !Inventory.has_item(item_name):
				Inventory.add_item_by_title(item_name, 1)
				Inventory.coins -= price


func _on_shop_item_focus_entered() -> void:
	$selected.visible = true


func _on_shop_item_focus_exited() -> void:
	$selected.visible = false


func _on_Timer_timeout() -> void:
	disabled = false
