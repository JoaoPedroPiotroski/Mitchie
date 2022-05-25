extends Entity
class_name ItemDrop

export var item : PackedScene
var gravity = 100

func _ready():
	if item == null:
		queue_free()
	else:
		$Sprite.texture = item.instance().icon
	
func _physics_process(delta):
	move_and_collide(Vector2.DOWN * gravity * delta)

func setup(in_item=item, in_layer=0):
	item = in_item
	layer = in_layer
	
func collect():
	queue_free()
