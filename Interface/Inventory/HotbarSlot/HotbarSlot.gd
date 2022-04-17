extends Panel

var item : Item
var empty_slot_tex : StreamTexture

func start(in_item : Item):
	$TextureButton.texture_normal = in_item.icon
	item = in_item

func _ready():
	if !is_instance_valid(item): 
		$TextureButton.texture_normal = empty_slot_tex


func _on_ItemReceiver_area_entered(area):
	if area is DragItem:
		item = area.item
