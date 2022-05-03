extends Panel

var item : Item
var pos : int
var empty_slot_tex : StreamTexture
var selected = false
var draggable = true

func start(in_item : Item, in_pos, in_draggable = true, in_selected = false):
	$TextureButton.texture_normal = in_item.icon
	item = in_item
	pos = in_pos
	draggable = in_draggable
	selected = in_selected

func _ready():
	if !is_instance_valid(item): 
		$TextureButton.texture_normal = empty_slot_tex
		
func update_texture():
	if selected:
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(1, 1, 1, 0.5)
	if !is_instance_valid(item): 
		$TextureButton.texture_normal = empty_slot_tex
		return
	$TextureButton.texture_normal = item.icon

