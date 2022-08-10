extends ParallaxLayer

var speed = 0 

func _physics_process(delta):
	motion_offset.x += speed * delta
