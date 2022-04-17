extends Panel

var item : Item

func start(in_item : Item):
	$TextureButton.texture_normal = in_item.icon
	item = in_item
