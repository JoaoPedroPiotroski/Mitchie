extends Entity

var direction
var speed = 1000

func start(pos, dir, player_global_position):
	rotation = dir
	position = pos
	direction = pos.direction_to(player_global_position)

func _physics_process(_delta):
# warning-ignore:return_value_discarded
	move_and_slide(direction * speed)

func _on_Timer_timeout():
	_die()
