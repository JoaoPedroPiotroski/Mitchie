extends Entity

const UP = Vector2.UP

var input_direction : float = 0
var velocity : Vector2 = Vector2.ZERO
var jump_timer : float = -1
var jump_cooldown: float = -1
var layer_switch_timer : float = -1

var colliding_with_layer_1 = false
var colliding_with_layer_2 = false

export(float) var acceleration : float = 10
export(float) var max_speed : float = 400
export(float) var friction: float = 0.3
export(float) var gravity: float = 10
export(float) var jump_force : float = 600

func _ready():
	set_layer(layer)

func _take_input():
	input_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))

	if Input.is_action_just_pressed("switch_layer"):
		layer_switch_timer = 1
		if is_on_floor():
			jump(300)
	if Input.is_action_just_pressed("jump"): 
		jump_timer = 0.2

func _process(delta):
	_take_input()
	velocity = move_and_slide(velocity, UP)
	
	velocity.x += acceleration * input_direction
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	if input_direction == 0 :
		if is_on_floor():
			velocity.x = lerp(velocity.x, 0, friction)
		else:
			velocity.x = lerp(velocity.x, 0, friction/4)
			
	if velocity.y > 0: 
		velocity.y += gravity * 1.3
	else:
		velocity.y += gravity
	velocity.y = min(velocity.y, 350)
	layer_switch_timer -= delta
	if layer == Global.layers.Layer1: 
		if !colliding_with_layer_2 and layer_switch_timer > 0:
			_switch_layer()
			layer_switch_timer = -1
	else:
		if !colliding_with_layer_1  and layer_switch_timer > 0:
			_switch_layer()
			layer_switch_timer = -1
	jump_timer -= delta
	jump_cooldown -= delta
	if jump_timer > 0 and is_on_floor() and jump_cooldown < 0:
		jump_cooldown = 0.1
		jump_timer = -1
		jump(jump_force)


func _on_Player_layer_changed():
	Global.set_player_layer(layer)
	if layer == 1:
		var tween = get_node("CameraZoomTween")
		tween.interpolate_property($Camera2D, "zoom",
				$Camera2D.zoom, Vector2(1, 1), 0.5,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		var tween = get_node("CameraZoomTween")
		tween.interpolate_property($Camera2D, "zoom",
				$Camera2D.zoom, Vector2(1.1, 1.1), 0.5,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func jump(force):
	velocity.y = -force


func _on_LayerDetector1_body_entered(body):
	colliding_with_layer_1 = true


func _on_LayerDetector1_body_exited(body):
	colliding_with_layer_1 = false


func _on_LayerDetector2_body_entered(body):
	colliding_with_layer_2 = true


func _on_LayerDetector2_body_exited(body):
	colliding_with_layer_2 = false
