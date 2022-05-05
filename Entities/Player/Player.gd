extends Entity
class_name Player

# Directions
const UP = Vector2.UP
const DOWN = Vector2.DOWN
const LEFT = Vector2.LEFT
const RIGHT = Vector2.RIGHT

# Timers
export(float) var jump_timer = -1 #0.3
export(float) var ground_timer = -1 #0.2
export(float) var layer_switch_timer = -1 #1

# Cooldowns
export(float) var jump_cooldown = ground_timer

var flags = {
	"on_ground" : false
}

var selected_item : Item 
var anim_direction : Vector2 = RIGHT
var velocity : Vector2 = Vector2.ZERO
var input_direction : int = 0
var layer_1_bodies = [] 
var layer_2_bodies = []
var colliding_with_layer_1 = false
var colliding_with_layer_2 = false
var next_animation = "Idle"

onready var animation_player = $AnimationPlayer
onready var main_sprite = $MainSprite
onready var state_machine = $StateMachine
onready var current = $Stats/Current
onready var base = $Stats

func _physics_process(delta):
	if abs(velocity.x) < 10:
		velocity.x = 0
	print(velocity)
	var state = state_machine.get_state()
	velocity = move_and_slide(velocity, UP)
	
	print(state)
	# Timers tick
	layer_switch_timer -= delta
	ground_timer -= delta
	jump_timer -= delta
	jump_cooldown -= delta
	
	# Ground handling
	if is_on_floor():
		ground_timer = 0.2
	flags["on_ground"] = ground_timer > 0
		
	if state == "Idle": 
		idle_state(delta)
	elif state == "Walk":
		walk_state(delta)
	elif state == "Jump":
		jump_state(delta)
	elif state == "Ascent":
		ascent_state(delta)
	elif state == "Descent":
		descent_state(delta)
	elif state == "Land":
		land_state(delta)
	elif state == "Dialog":
		dialog_state(delta)
	animate()
		
func take_input():
	input_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	if input_direction != 0:
		anim_direction.x = input_direction
	if Input.is_action_just_pressed("switch_layer"):
		layer_switch_timer = 1
		jump_timer = 0.2
	if Input.is_action_just_pressed("jump"): 
		jump_timer = 0.2

func animate():
	main_sprite.flip_h = anim_direction.x < 0
	if next_animation != animation_player.current_animation:
		animation_player.play(next_animation)

func ground_move(delta):
	velocity.x += current.acceleration * delta * input_direction
	velocity.x = clamp(velocity.x, -current.max_speed, current.max_speed)

func air_move(delta):
	velocity.x += current.acceleration * current.air_acceleration_modifier * delta * input_direction
	velocity.x = clamp(velocity.x, -current.max_speed, current.max_speed)

func update_layer(delta):
	if layer == Global.layers.Layer1: 
		if !colliding_with_layer_2 and layer_switch_timer > 0:
			switch_layer()
			layer_switch_timer = -1
	elif layer == Global.layers.Layer2:
		if !colliding_with_layer_1  and layer_switch_timer > 0:
			switch_layer()
			layer_switch_timer = -1
	
func _die():
	get_tree().reload_current_scene()
	
func _respawn():
	get_tree().reload_current_scene()
	
func apply_friction(force, delta):
	velocity.x = lerp(velocity.x, 0, force * delta)

func apply_gravity(force, delta):
	velocity.y += force * delta
	velocity.y = min(velocity.y, current.terminal_velocity)

func apply_jump_impulse(force):
	velocity.y = -force

func idle_state(_delta):
	next_animation = "Idle"
	take_input()
	if input_direction != 0:
		state_machine.current_state = "Walk"
	if jump_timer > 0 and jump_cooldown < 0:
		jump_cooldown = 0.2
		state_machine.current_state = "Jump"
	
func walk_state(delta):
	next_animation = "Walk"
	take_input()
	ground_move(delta)
	if input_direction != 0:
		apply_friction(current.friction, delta)
	else:
		apply_friction(current.friction * current.stopping_friction_modifier, delta)
	apply_gravity(current.gravity, delta)
	
	if !flags["on_ground"]:
		state_machine.current_state = "Descent"
	if jump_timer > 0 and jump_cooldown < 0:
		jump_cooldown = 0.2
		state_machine.current_state = "Jump"
	if input_direction == 0 and velocity.x == 0:
		state_machine.current_state = "Idle"
		
func jump_state(_delta):
	take_input()
	next_animation = "Jump"

func ascent_state(delta):
	pass
	
func descent_state(delta):
	state_machine.current_state = "Walk"

func land_state(_delta):
	pass

func dialog_state(_delta):
	pass
	
func is_inverse(n1, n2):
	if (n1 > 0 and n2<0) or (n1 < 0 and n2>0):
		return true
	return false

func _on_LayerDetector1_body_entered(body):
	layer_1_bodies.append(body)
	colliding_with_layer_1 = true


func _on_LayerDetector1_body_exited(body):
	layer_1_bodies.erase(body)
	if layer_1_bodies.size() == 0: 
		colliding_with_layer_1 = false


func _on_LayerDetector2_body_entered(body):
	layer_2_bodies.append(body)
	colliding_with_layer_2 = true


func _on_LayerDetector2_body_exited(body):
	layer_2_bodies.erase(body)
	if layer_2_bodies.size() == 0:
		colliding_with_layer_2 = false
