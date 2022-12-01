extends Enemy

var desired_position : Vector2
var movement_direction : Vector2

var acceleration = 40
var player
var max_speed = 50
var attacking = false

onready var angle_helper = $PlayerAngleHelper

func spawn_bullet():
	print('tiro')
	var bullet = load("res://Entities/Enemies/Eye/Bullet.tscn")
	var b = bullet.instance()
	b.start(global_position, player)
	get_parent().add_child(b) 

func _physics_process(delta: float) -> void:
	desired_position = angle_helper.tgt_pos.global_position
	var desired_dir = global_position.direction_to(desired_position)
	movement_direction = lerp(movement_direction, desired_dir, .1)
	velocity += acceleration * movement_direction
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	
	if !attacking:
		print('mexendo')
		velocity = move_and_slide(velocity)


func _on_BulletShoot_timeout() -> void:
	pass # Replace with function body.


func _on_PlayerAngleHelper_shoot(_player) -> void:
	player = _player
	$AnimationPlayer.play("Attack")
	attacking = true

func return_to_idle() -> void:
	$AnimationPlayer.play("Idle")
	attacking = false
