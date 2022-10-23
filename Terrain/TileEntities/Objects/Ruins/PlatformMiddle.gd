extends StaticBody2D

var down_timer = 0

func _physics_process(delta):
	if Input.is_action_pressed("move_down"):
		down_timer += delta
	else: 
		down_timer = 0
	if down_timer > 0.2:
		call_deferred('disable_col')

func disable_col():
	set_collision_mask_bit(2, false)
	yield(get_tree().create_timer(.1), "timeout")
	call_deferred('enable_col')

func enable_col():
	set_collision_mask_bit(2, true)
