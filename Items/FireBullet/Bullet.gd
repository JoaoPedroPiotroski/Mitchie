extends Entity

var direction
var speed = 1000

func start(pos : Vector2, dir : Vector2, origin_layer):
	direction = dir
	direction = pos.direction_to(dir)
	set_layer(origin_layer)
	position = pos
	set_layer(origin_layer)
	$Hitbox.layer = origin_layer

func _physics_process(_delta):
# warning-ignore:return_value_discarded
	move_and_slide(direction * speed)


func _on_Timer_timeout():
	_die()
