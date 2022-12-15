extends Enemy

enum States {
	SLEEP,
	WALK,
	CHASE,
	WHIRL,
	STUN,
	SPAWNING
}
var State = States.SLEEP

enum ArmorStates {
	BROKEN,
	WHOLE
}
var ArmorState = ArmorStates.WHOLE

var player_on_ground = false
var player
var move_direction = Vector2.ZERO
var speed = 100
var gravity = 200

var whirl_start : Vector2 = Vector2.ZERO
var whirl_just_started = true
var whirl_dir = -1

func _physics_process(delta):
	player = Global.player
	if !is_instance_valid(player):
		return
	velocity = move_direction * speed
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)
	if State != States.WHIRL:
		whirl_just_started = true
	
	match(ArmorState):
		ArmorStates.BROKEN:
			$armorlabel.text = "BROKen"
			pass
		ArmorStates.WHOLE:
			$armorlabel.text = "WHOLE"
	
	match(State):
		States.SLEEP:
			pass
			$statelabel.text = "SLEEP"
		States.WALK:
			$statelabel.text = "WALK"
			if wall_detector():
				move_direction.x *= -1
			if player_on_ground:
				State = States.CHASE
		States.CHASE:
			$statelabel.text = "Chase"
			move_direction.x = global_position.direction_to(player.global_position).x
			if not player_on_ground:
				State = States.WALK
		States.WHIRL:
			if whirl_just_started:
				whirl_start = global_position
				whirl_just_started = false
				if global_position.direction_to(player.global_position).x < 0:
					whirl_dir = 1
				else:
					whirl_dir = -1
			move_direction.x = whirl_dir
			$statelabel.text = "WHIRL"
			pass
		States.STUN:
			$statelabel.text = "STUN"
			move_direction = Vector2.ZERO
			pass

func apply_damage(dmg, atk_pos = null):
	print('apanhei')
	match(State):
		States.SLEEP:
			State = States.CHASE   
			move_direction = Vector2.LEFT
		States.CHASE:
			match(ArmorState):
				ArmorStates.BROKEN:
					if global_position.direction_to(atk_pos).dot(move_direction) < 0:
						health -= dmg
						ArmorState = ArmorStates.WHOLE
				ArmorStates.WHOLE:
					if global_position.direction_to(atk_pos).dot(move_direction) > 0:
						ArmorState = ArmorStates.BROKEN
						State = States.STUN
		States.WALK:
			match(ArmorState):
				ArmorStates.BROKEN:
					if global_position.direction_to(atk_pos).dot(move_direction) > 0:
						health -= dmg
						ArmorState = ArmorStates.WHOLE
				ArmorStates.WHOLE:
					if global_position.direction_to(atk_pos).dot(move_direction) < 0:
						ArmorState = ArmorStates.BROKEN
		States.STUN:
			match(ArmorState):
				ArmorStates.BROKEN:
					if global_position.direction_to(atk_pos).dot(move_direction) > 0:
						health -= dmg
						State = States.CHASE
						ArmorState = ArmorStates.WHOLE
				ArmorStates.WHOLE:
					if global_position.direction_to(atk_pos).dot(move_direction) < 0:
						ArmorState = ArmorStates.BROKEN
	if State == States.STUN:
		$stuntimer.start(3)

func wall_detector():
	if $detectors/WallDetector1.is_colliding() and move_direction.x > 0:
		return true
	if $detectors/WallDetector2.is_colliding() and move_direction.x < 0:
		return true	
	return false

func floor_detector():
	if !$detectors/FloorDetector1.is_colliding():
		return true
	if !$detectors/FloorDetector2.is_colliding():
		return true	
	return false

func _on_PlayerDetector_player_changed():
	if is_instance_valid($PlayerDetector.player):
		player_on_ground = true
	else:
		player_on_ground = false
		




func _on_stuntimer_timeout() -> void:
	State = States.WHIRL
