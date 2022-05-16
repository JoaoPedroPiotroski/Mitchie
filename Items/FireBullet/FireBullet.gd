extends Item


var bullet 

func _use(origin, origin_layer): 
	bullet = load("res://Items/FireBullet/Bullet.tscn")
	spawn_bullet(origin, origin_layer)

func spawn_bullet(origin, origin_layer):
	var b = bullet.instance()
	b.start(origin, Global.mouse_position, origin_layer)
	
	Global.player.get_parent().add_child(b)
