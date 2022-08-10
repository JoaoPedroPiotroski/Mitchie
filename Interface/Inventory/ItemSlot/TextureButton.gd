extends TextureButton


func get_drag_data(_position):
	var data = {
		'item' : get_parent().item
	}
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = texture_normal
	drag_texture.rect_size = Vector2(64, 64)
	drag_texture.rect_min_size = Vector2(64, 64)
	set_drag_preview(drag_texture)
	return data
	
