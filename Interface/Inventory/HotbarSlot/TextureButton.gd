extends TextureButton


func get_drag_data(position):
	var data = {
		"item" : get_parent().item
	}
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = get_parent().item.icon
	drag_texture.rect_size = Vector2(64, 64)
	set_drag_preview(drag_texture)
	return data
	

func can_drop_data(position, data):
	return true
	return false

func drop_data(position, data):
	get_parent().item = data['item']
	get_parent().update_texture()
