extends Entity
class_name Player

# Directions
const UP = Vector2.UP
const DOWN = Vector2.DOWN
const LEFT = Vector2.LEFT
const RIGHT = Vector2.RIGHT

var debug_draw_aux = Vector2.ZERO

# Timers
var jump_timer = -1 #0.3
var ground_timer = -1 #0.1
var layer_switch_timer = -1 #1
var fall_timer : float = 0
var l_click_hold_timer = 0
var r_click_hold_timer = 0

# Cooldowns
export(float) var jump_cooldown = ground_timer
export(float) var invulnerability_timer = .6
var invulnerable = false

var flags = {
	"on_ground" : false,
	"dead" : false,
	"stopped" : false
}

#var selected_item : Resource

var anim_direction : Vector2 = RIGHT
var input_direction : int = 0
var layer_1_bodies = [] 
var layer_2_bodies = []
var intermediary_bodies = []
var colliding_with_layer_1 = false
var colliding_with_intermediary = false
var colliding_with_layer_2 = false
var next_animation = "Idle"
var moving = true
var animating = true
var item_hover
var current_door
var current_dialog
var current_savepoint
var has_scythe = false
var anim_direction_locked = false
var world_image

onready var animation_player = $AnimationPlayer
onready var main_sprite = $MainSprite
onready var state_machine = $StateMachine
onready var current = $Stats/Current
onready var base = $Stats

func _ready():
	var _c = Inventory.connect('inventory_changed', self, 'update_inventory')
	update_inventory()
	yield(get_tree().create_timer(0.1), "timeout")
	for d in get_tree().get_nodes_in_group('doors'):
		if d.entrance == SceneManager.entrance:
			global_position = d.global_position
			if d.is_in_group('savepoints'):
				state_machine.current_state = 'Saving'
				global_position = d.global_position
				global_position.y -= 4
				global_position.x -= 30
				$Sprite.flip_h = true
	$WalkOnSand.color = SceneManager.level.dust_color
	$WalkOnSand.amount = SceneManager.level.dustyness
	
func _physics_process(delta):
	Global.player = self
	Global.mouse_position = get_global_mouse_position()
	var state = state_machine.get_state()
	if moving:
		velocity = move_and_slide(velocity, UP)
	# Timers tick
	layer_switch_timer -= delta
	ground_timer -= delta
	jump_timer -= delta
	jump_cooldown -= delta
	main_sprite.material.set_shader_param('invincible', invulnerable)
	main_sprite.material.set_shader_param('time_remaining', $InvulnerabilityTimer.time_left)
	
	# Ground handling
	if is_on_floor():
		ground_timer = 0.1
	flags["on_ground"] = ground_timer > 0
	if velocity.x < 0.1 and velocity.x > -0.1:
		flags['stopped'] = true
	else:
		flags['stopped'] = false

	if state == "Walk":
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
	elif state == "Attack":
		attack_state(delta)
	elif state == "Attack2":
		attack2_state(delta)
	elif state == "Pull":
		pull_state(delta)
	elif state == "Pull2":
		pull2_state(delta)
	elif state == "Saving":
		saving_state(delta)
	if animating:
		animate()
		
	if layer_switch_timer < 0:
		current.jump_force = base.jump_force
	
func take_input(delta):
	input_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	if input_direction != 0:
		anim_direction.x = input_direction
	if Input.is_action_just_pressed("jump"): 
		jump_timer = 0.2
	if Input.is_action_pressed("attack"):
		l_click_hold_timer += delta
	if Input.is_action_pressed("pull"):
		r_click_hold_timer += delta
	if Input.is_action_just_released("attack"):
		if l_click_hold_timer > 0.2:
			state_machine.current_state = "Attack2"
		else:
			state_machine.current_state = "Attack"
		l_click_hold_timer = 0
	if Input.is_action_just_released("pull"):
		if r_click_hold_timer > 0.2:
			state_machine.current_state = "Pull"
		else:
			state_machine.current_state = "Pull"
		r_click_hold_timer = 0
	if weakref(current_dialog).get_ref():
		if Input.is_action_just_pressed("interact"):
			state_machine.current_state = "Dialog"
			moving = false
			animating = false
			animation_player.stop(false)
			add_child(current_dialog)
			current_dialog.connect("timeline_end", self, "_on_dialog_ended")
	if Input.is_action_just_pressed("move_up"):
		if weakref(current_door).get_ref():
			SceneManager.entrance = current_door.destination_entrance
			SceneManager.change_level(current_door.destination_level)
		if weakref(current_savepoint).get_ref() and flags['on_ground']:
			state_machine.current_state = "Saving" 
			Save.level = SceneManager.level.title
			Save.entrance = current_savepoint.entrance
			Save.store_save()
#	if weakref(item_hover).get_ref():
#		if Input.is_action_just_pressed("interact") and item_hover.layer == layer:
#			var pass_item = item_hover.item.instance()
#			Inventory.add_item(pass_item)
#			item_hover.collect()
		
func animate():
	if not anim_direction_locked:
		main_sprite.flip_h = anim_direction.x < 0
		if state_machine.current_state in [
			"Attack", "Attack2", "Pull", "Pull2"
		]:
			anim_direction.x = $Directions.get_input_direction().x if $Directions.get_input_direction().x != 0 else 1
	if state_machine.current_state in [
			"Attack", "Attack2", "Pull", "Pull2"
	]:
		anim_direction_locked = true
	else:
		anim_direction_locked = false
	
	if state_machine.current_state == "Walk" and input_direction != 0:
		$WalkOnSand.direction = Vector2(global_position.direction_to(global_position+velocity).x, 0) * -1
		$WalkOnSand.emitting = true
	else:
		$WalkOnSand.emitting = false
	
	if next_animation != animation_player.current_animation and animation_player.current_animation != "die":
		animation_player.play(next_animation)
	if flags["dead"] and animation_player.current_animation != "die":
		animation_player.play("die")
	
func ground_move(delta):
	velocity.x += current.acceleration * delta * input_direction
	velocity.x = clamp(velocity.x, -current.max_speed, current.max_speed)

func air_move(delta):
	velocity.x += current.acceleration * current.air_acceleration_modifier * delta * input_direction
	velocity.x = clamp(velocity.x, -current.max_speed, current.max_speed)

#func update_layer(delta):
#	if !colliding_with_intermediary:
#		if layer == Global.layers.Layer1: 
#			if !colliding_with_layer_2 and layer_switch_timer > 0:
#				switch_layer()
#				Global.player_layer = layer
#				layer_switch_timer = -1
#		elif layer == Global.layers.Layer2:
#			if !colliding_with_layer_1  and layer_switch_timer > 0:
#				switch_layer()
#				Global.player_layer = layer
#				layer_switch_timer = -1
		
func _die():
	flags["dead"] = true
	current.health = current.max_health
	
func _respawn():
	Save.load_save()
	
func apply_friction(force, delta):
	velocity.x = lerp(velocity.x, 0, force * delta)

func apply_gravity(force, delta):
	velocity.y += force * delta
	velocity.y = min(velocity.y, current.terminal_velocity)

func apply_jump_impulse(force):
	velocity.y = -force
	
func apply_damage(dmg, _dealer = null):
	if !invulnerable:
		current.health -= dmg
		invulnerable = true
		$InvulnerabilityTimer.start(invulnerability_timer)
		AudioManager.play_fx("res://Entities/Player/hurt.sfxr")
	if current.health <= 0:
		_die()
	
func walk_state(delta):
	if input_direction != 0:
		next_animation = "Walk"
	else:
		next_animation = "Idle"
	take_input(delta)
	ground_move(delta)
	if input_direction == 0 or is_inverse(input_direction, velocity.x):
		apply_friction(current.friction * current.stopping_friction_modifier, delta)
	else:
		apply_friction(current.friction, delta)
	
	apply_gravity(current.gravity, delta)
	
	if !flags["on_ground"]:
		state_machine.current_state = "Descent"
	if jump_timer > 0 and jump_cooldown < 0:
		jump_cooldown = 0.3
		state_machine.current_state = "Jump"
		
func jump_state(delta):
	take_input(delta)
	next_animation = "Jump"
	apply_jump_impulse(current.jump_force)
	state_machine.current_state = "Ascent"

func ascent_state(delta):
	next_animation = "Ascent"
	take_input(delta)
	air_move(delta)
	if input_direction == 0 or is_inverse(input_direction, velocity.x):
		apply_friction(current.friction * current.stopping_friction_modifier * current.air_friction_modifier, delta)
	else:
		apply_friction(current.friction * current.air_friction_modifier, delta)
	apply_gravity(current.gravity, delta)
	# if is on ground or velocity.y > 0 state = descent
	if is_on_floor() or velocity.y > 0:
		state_machine.current_state = "Descent"
	if Input.is_action_just_released("jump"):
		velocity.y *= 0.1
	
	
func descent_state(delta):
	fall_timer += delta 
	next_animation = "Fall"
	take_input(delta)
	air_move(delta)
	if input_direction == 0 or is_inverse(input_direction, velocity.x):
		apply_friction(current.friction * current.stopping_friction_modifier * current.air_friction_modifier, delta)
	else:
		apply_friction(current.friction * current.air_friction_modifier, delta)
	apply_gravity(current.gravity * current.falling_gravity_modifier, delta)
	# if is on ground or velocity.y > 0 state = descent
	if flags["on_ground"]:
		state_machine.current_state = "Walk"
		if fall_timer > 0.75:
			state_machine.current_state = "Land"
		fall_timer = 0

func saving_state(_delta):
	velocity = Vector2.ZERO
	current.health = current.max_health
	next_animation = "saving"
	if Input.is_action_just_pressed('move_up'):
		state_machine.current_state = "Walk"

func land_state(_delta):
	next_animation = "Landing"
	
func end_landing():
	state_machine.current_state = "Walk"

func dialog_state(_delta):
	pass
	
func attack_state(delta):
	apply_friction(current.friction, delta)
	apply_gravity(current.gravity, delta)
	next_animation = "attack1"
func end_attack():
	moving = true
	state_machine.current_state = "Walk"

func attack2_state(_delta):
	if current.mana <= 0:
		state_machine.current_state = "Walk"
		return
	var scy = load("res://Entities/Player/ScytheBomb.tscn")
	var obj = scy.instance()
	obj.start($Directions.get_input_direction(), 300, global_position)
	get_parent().add_child(obj)
	current.mana -= 1
	state_machine.current_state = "Walk"

func pull_state(_delta):
	next_animation = "pull1"
	moving = false
func pull1_end():
	moving = true
	state_machine.current_state = "Walk"

func pull2_state(_delta):
	pass
	
func update_inventory():
	if Inventory.has_item('Foice'):
		has_scythe = true

func _knockback(force, dir):
	if not invulnerable:
		velocity = force * dir
	
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
		
func _on_dialog_ended(_timeline):
	moving = true
	animation_player.play() 
	state_machine.current_state = "Walk"
	animating = true
	current_dialog = null


func _on_InvulnerabilityTimer_timeout():
	invulnerable = false





func _on_Player_tree_exiting():
	Global.player = null
