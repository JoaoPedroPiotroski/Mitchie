extends Sprite

onready var main_sprite = get_parent().get_node("MainSprite") 

func _physics_process(delta):
	visible = false
	frame = main_sprite.frame
	flip_h = main_sprite.flip_h
	

