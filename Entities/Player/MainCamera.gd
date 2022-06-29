extends Camera2D

onready var player = get_parent()
onready var camera_tween = $CameraTween
onready var vignette = $CanvasLayer/Vignette
onready var vignette_tween = $VignetteTween

var up_timer = 0.5
var down_timer = 0.5
var right_timer = 0.3
var left_timer = 0.3

func _physics_process(delta):
	drag_margin_h_enabled = !abs(player.velocity.x) > 200
	left_timer = 3
	right_timer = 3
#	if Input.is_action_pressed("move_up"):
#		up_timer -= delta
#	else:
#		up_timer = 0.5
#	if Input.is_action_pressed("move_down"):
#		down_timer -= delta
#	else:
#		down_timer = 0.5
	if down_timer > 0 and up_timer > 0:
		offset_v = 0
	else:
		if down_timer < 0  and player.flags['stopped']:
			offset_v = 1
		if up_timer < 0  and player.flags['stopped']:
			offset_v = -2
	if Input.is_action_pressed("move_right"):
		right_timer -= delta
	else:
		right_timer = 0.3
	if Input.is_action_pressed("move_left"):
		left_timer -= delta
	else:
		left_timer = 0.3
	if right_timer < 0:
		camera_tween.interpolate_property(self, "offset_h", offset_h, 1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		camera_tween.start()
	elif left_timer < 0:
		camera_tween.interpolate_property(self, "offset_h", offset_h, -1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		camera_tween.start()
	else:
		camera_tween.interpolate_property(self, "offset_h", offset_h, 0, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	if player.layer == 0:
		camera_tween.interpolate_property(self, "zoom", zoom, Vector2(0.84, 0.84), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		vignette_tween.interpolate_property(vignette.get_material(), 
			   "shader_param/vignette_intensity", 
			   vignette.material.get_shader_param("shader_param/vignette_intensity"), 0.1, 0.25, 
			   Tween.TRANS_CUBIC, Tween.EASE_OUT)
		vignette_tween.start()
		camera_tween.start()
	else:
		camera_tween.interpolate_property(self, "zoom", zoom, Vector2(0.8, 0.8), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		vignette_tween.interpolate_property(vignette.get_material(), 
			   "shader_param/vignette_intensity", 
			   vignette.material.get_shader_param("shader_param/vignette_intensity"), 0.2, 0.25, 
			   Tween.TRANS_CUBIC, Tween.EASE_OUT)
		vignette_tween.start()
		camera_tween.start()
	return
	if !(abs(player.velocity.x) > 200):
		drag_margin_left = 0
		drag_margin_right = 0
	else:
		drag_margin_left = 0.2
		drag_margin_right = 0.2
