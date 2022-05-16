extends PseudoEntity
class_name ItemDrop

export var item : PackedScene

func _ready():
	if item == null:
		print('num existo :()')
		queue_free()

func setup(in_item=item, in_layer=0):
	item = in_item
	layer = in_layer
	
func collect():
	queue_free()
