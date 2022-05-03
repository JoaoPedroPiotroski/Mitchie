extends Sprite

onready var main_sprite = get_parent().get_node("MainSprite") 

func _physics_process(delta):
	visible = get_parent().is_on_floor()
	frame = main_sprite.frame
	flip_h = main_sprite.flip_h
	

