extends Area2D
class_name Door

export(String, "door", "entrance") var type = 'door'
export(String, FILE, "*.png") var texture
export(int) var entrance = 0
export(String) var destination_level
export(int) var destination_entrance = 0

func _ready():
	add_to_group('doors')
	var sprite = Sprite.new()
	if texture != "":
		sprite.texture = load(texture)
		add_child(sprite)
	set_collision_mask_bit(0, false)
	set_collision_layer_bit(0, false)
	set_collision_layer_bit(4, true)
	hide_hint()

func show_hint():
	if has_node('door_hint'):
		get_node('door_hint').visible = true
	
func hide_hint():
	if has_node('door_hint'):
		get_node('door_hint').visible = false
