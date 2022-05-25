extends Camera2D

onready var player = get_parent()
onready var zoom_tween = $CameraZoomTween
onready var vignette = $CanvasLayer/Vignette
onready var vignette_tween = $VignetteTween

func _physics_process(delta):
	if player.state_machine.current_state in ["Jump", "Ascent", "Descent"] and player.layer_switch_timer < 0:
		drag_margin_v_enabled = true
	elif player.layer_switch_timer > 0:
		drag_margin_v_enabled = false
	else:
		drag_margin_v_enabled = false
	drag_margin_h_enabled = !abs(player.velocity.x) > 200
	
	if player.layer == 0:
		zoom_tween.interpolate_property(self, "zoom", zoom, Vector2(0.84, 0.84), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		vignette_tween.interpolate_property(vignette.get_material(), 
						   "shader_param/vignette_intensity", 
						   vignette.material.get_shader_param("shader_param/vignette_intensity"), 0.1, 0.5, 
						   Tween.TRANS_LINEAR, Tween.EASE_OUT)
		vignette_tween.start()
		zoom_tween.start()
	else:
		zoom_tween.interpolate_property(self, "zoom", zoom, Vector2(0.8, 0.8), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		vignette_tween.interpolate_property(vignette.get_material(), 
						   "shader_param/vignette_intensity", 
						   vignette.material.get_shader_param("shader_param/vignette_intensity"), 0.4, 0.5, 
						   Tween.TRANS_LINEAR, Tween.EASE_OUT)
		vignette_tween.start()
		zoom_tween.start()
		
	if !(abs(player.velocity.x) > 200):
		drag_margin_left = 0
		drag_margin_right = 0
	else:
		drag_margin_left = 0.2
		drag_margin_right = 0.2
