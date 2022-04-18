extends Entity
class_name Player

const UP = Vector2.UP

var input_direction : float = 0
var velocity : Vector2 = Vector2.ZERO
var jump_timer : float = -1
var jump_cooldown: float = -1
var layer_switch_timer : float = -1

var colliding_with_layer_1 = false
var colliding_with_layer_2 = false

export(float) var acceleration : float = 1000
export(float) var max_speed : float = 250
export(float) var friction: float = 30
export(float) var gravity: float = 2000
export(float) var jump_force : float = 650

func _ready():
	# tem que fazer isso pra não bugar
	set_layer(layer)

func take_input():
	input_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))

	if Input.is_action_just_pressed("switch_layer"):
		layer_switch_timer = 1
		if is_on_floor():
			jump(400)
	if Input.is_action_just_pressed("jump"): 
		jump_timer = 0.2

func _die():
	var _leave = get_tree().reload_current_scene()

func _physics_process(delta):
	take_input()
	velocity = move_and_slide(velocity, UP)
	
	# Velocidade en movimento padrão
	
	velocity.x += acceleration * delta * input_direction
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	# Fricção
	
	if input_direction == 0 :
		if is_on_floor():
			velocity.x = lerp(velocity.x, 0, friction * delta)
		else:
			velocity.x = lerp(velocity.x, 0, friction/4 * delta)
	
	# Gravidade, mais forte qando caindo
	if velocity.y > 0: 
		velocity.y += gravity * 2 * delta
	else:
		velocity.y += gravity * delta
	velocity.y = min(velocity.y, 600)
	
	# Troca de camada
	layer_switch_timer -= delta
	if layer == Global.layers.Layer1: 
		if !colliding_with_layer_2 and layer_switch_timer > 0:
			switch_layer()
			layer_switch_timer = -1
	else:
		if !colliding_with_layer_1  and layer_switch_timer > 0:
			switch_layer()
			layer_switch_timer = -1
	
	# Pulo
	
	jump_timer -= delta
	jump_cooldown -= delta
	if jump_timer > 0 and is_on_floor() and jump_cooldown < 0:
		jump_cooldown = 0.1
		jump_timer = -1
		jump(jump_force)
	if Input.is_action_just_released("jump") and velocity.y < 0 and !is_on_floor():
		velocity.y *= 0.2


func _on_Player_layer_changed():
	Global.set_player_layer(layer)
	# Mudanças de zoom baseadas no layer
	if layer == 1:
		var tween = get_node("CameraZoomTween")
		tween.interpolate_property($MainCamera, "zoom",
				$MainCamera.zoom, Vector2(1, 1), 0.5,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		var tween = get_node("CameraZoomTween")
		tween.interpolate_property($MainCamera, "zoom",
				$MainCamera.zoom, Vector2(1.1, 1.1), 0.5,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func jump(force):
	velocity.y = -force


func _on_LayerDetector1_body_entered(_body):
	colliding_with_layer_1 = true


func _on_LayerDetector1_body_exited(_body):
	colliding_with_layer_1 = false


func _on_LayerDetector2_body_entered(_body):
	colliding_with_layer_2 = true


func _on_LayerDetector2_body_exited(_body):
	colliding_with_layer_2 = false
