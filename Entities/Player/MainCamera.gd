extends Camera2D

onready var player = get_parent()

func _physics_process(delta):
	if player.state_machine.current_state == "Jump" or player.state_machine.current_state == "Ascent":
		drag_margin_v_enabled = true
	else:
		drag_margin_v_enabled = false
	drag_margin_h_enabled = !abs(player.velocity.x) > 200
	if !(abs(player.velocity.x) > 200):
		drag_margin_left = 0
		drag_margin_right = 0
	else:
		drag_margin_left = 0.2
		drag_margin_right = 0.2
