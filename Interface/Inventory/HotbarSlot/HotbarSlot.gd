extends Panel

var item : Item
var pos : int
var empty_slot_tex : StreamTexture

func start(in_item : Item, in_pos):
	$TextureButton.texture_normal = in_item.icon
	item = in_item
	pos = in_pos

func _ready():
	if !is_instance_valid(item): 
		$TextureButton.texture_normal = empty_slot_tex
		
func update_texture():
	if !is_instance_valid(item): 
		$TextureButton.texture_normal = empty_slot_tex
		return
	$TextureButton.texture_normal = item.icon
		

