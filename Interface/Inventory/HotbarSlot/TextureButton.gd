extends TextureButton


func get_drag_data(position):
	if !get_parent().draggable:
		return
	var data = {
		"item" : get_parent().item,
		"origin" : get_parent().pos
	}
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = get_parent().item.icon
	drag_texture.rect_size = Vector2(64, 64)
	set_drag_preview(drag_texture)
	return data
	

func can_drop_data(position, data):
	if data.has('item'):
		return true
	return false

func drop_data(position, data):
	if data.has('origin'):
		Inventory.get_node("Hotbar").add_to_hotbar(data['item'], get_parent().pos, data['origin'])
		return
	Inventory.get_node("Hotbar").add_to_hotbar(data['item'], get_parent().pos)
	if get_parent().selected:
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(1, 1, 1, 0.5)
