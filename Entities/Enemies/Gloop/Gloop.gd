extends Enemy

var move_direction = Vector2.LEFT
var speed = 50
enum states {
	WALK,
	STUN
}
var player = null

export(float) var gravity = 670
var wall_timer = .5
var wall_cd = false
var floor_timer = .5
var floor_cd = false
var state = states.WALK

func wall_detector():
	if $detectors/WallDetector1.is_colliding() and !wall_cd:
		wall_cd = true
		wall_timer = .5
		return true
	if $detectors/WallDetector2.is_colliding() and !wall_cd:
		wall_cd = true
		wall_timer = .5
		return true	
	return false

func floor_detector():
	if !$detectors/FloorDetector1.is_colliding() and !floor_cd:
		floor_cd = true
		floor_timer = .5
		return true
	if !$detectors/FloorDetector2.is_colliding() and !floor_cd:
		floor_cd = true
		floor_timer = .5
		return true	
	return false

func apply_damage(damage):
	if weakref(player).get_ref():
		print('ELE EXISTE')
		if move_direction.dot(global_position.direction_to(player.global_position)) > 0:
			print('TOMOU HIT ATRAS')
			state = states.STUN
	else:
		print('TOMOU HIT NA FRENTE')
		health -= damage
	if health <= 0 and !immortal: 
		_die()

func _physics_process(delta):
	#FUNÇOES DE TESTE
	if weakref(player).get_ref():
		modulate = Color.red
	else:
		modulate = Color.white
	
	wall_timer -= delta
	if wall_timer <= 0:
		wall_cd = false
	floor_timer -= delta
	if floor_timer <= 0:
		floor_cd = false
	velocity = move_and_slide(velocity)
	velocity.y += gravity * delta
	match(state):
		states.WALK:
			if !weakref(player).get_ref():
				velocity.x = move_direction.x * speed
				if wall_detector():
					move_direction *= -1
				if floor_detector():
					move_direction *= -1
			else:
				move_direction = Vector2(
					global_position.direction_to(player.global_position).x,
					0
				).normalized()
				velocity.x = move_direction.x * speed
		states.STUN:
			if $StunTimer.is_stopped():
				$StunTimer.start(2)
			velocity.x = 0


func _on_PlayerDetector_player_changed():
	if weakref(player).get_ref():
		yield(get_tree().create_timer(1), 'timeout')
		player = null
		if move_direction.x < 0:
			move_direction = Vector2.LEFT
		else:
			move_direction = Vector2.RIGHT
	else:
		player = $PlayerDetector.player


func _on_StunTimer_timeout():
	state = states.WALK
	player = $PlayerDetector.player
