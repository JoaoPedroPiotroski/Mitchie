extends Enemy

var move_direction = Vector2.LEFT
var chase_speed = 55
var walk_speed = 20
enum states {
	WALK,
	STUN
}
var player = null

export(float) var gravity = 670.0
var wall_timer = .5
var wall_cd = false
var confusion_timer = 0
var floor_timer = .5
var floor_cd = false
var state = states.WALK
var chase_timer = 0
var player_detect1 = false
var player_detect2 = false
var turn_timer = 0

var dead = false

func wall_detector():
	if $detectors/WallDetector1.is_colliding() and !wall_cd:
		wall_cd = true
		wall_timer = .8
		return true
	if $detectors/WallDetector2.is_colliding() and !wall_cd:
		wall_cd = true
		wall_timer = .8
		return true	
	return false

func floor_detector():
	if !$detectors/FloorDetector1.is_colliding() and !floor_cd:
		floor_cd = true
		floor_timer = .8
		return true
	if !$detectors/FloorDetector2.is_colliding() and !floor_cd:
		floor_cd = true
		floor_timer = .8
		return true	
	return false
	
func does_player_hit(dealerpos):
	var dir_to_player = global_position.direction_to(dealerpos)
	if move_direction.x > 0:
		if dir_to_player.x > 0:
			return false
		return true
	elif move_direction.x < 0:
		if dir_to_player.x < 0:
			return false
		return true

func apply_damage(damage, dealerpos = null):
	if weakref(Global.player).get_ref():
		if does_player_hit(dealerpos):
			health -= damage
		else:
			state = states.STUN
	if health <= 0 and !immortal:
		$AnimationPlayer.play('die')
		golden_shower()
		dead = true
	
#	if weakref(player).get_ref():
#		print('ELE EXISTE')
#		if move_direction.dot(global_position.direction_to(player.global_position)) > 0:
#			print('TOMOU HIT ATRAS')
#			state = states.STUN
#	else:
#		print('TOMOU HIT NA FRENTE')
#		health -= damage
#	if health <= 0 and !immortal: 
#		_die()

func _physics_process(delta):
	if dead:
		return
	$Sprite.flip_h = move_direction.x > 0
	$PlayerDetectorExt/CollisionShape2D.set_deferred('disabled', !(player_detect2 or player_detect1))
	#FUNÇOES DE TESTE
	turn_timer -= delta
	
	wall_timer -= delta
	if wall_timer <= 0:
		wall_cd = false
	floor_timer -= delta
	if floor_timer <= 0:
		floor_cd = false
	
	confusion_timer -= delta
	if confusion_timer < 0:
		velocity = move_and_slide(velocity)
	else:
		velocity.x = 0
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity)
	velocity.y += gravity * delta
	match(state):
		states.WALK:
			$Star.visible = false
			if !weakref(player).get_ref():
				$AnimationPlayer.play("Walk")
				velocity.x = move_direction.x * walk_speed
				if wall_detector():
					move_direction *= -1
				if floor_detector():
					move_direction *= -1
			else:
				$AnimationPlayer.play("Chase")
				if turn_timer < 0:
					move_direction = Vector2(
						global_position.direction_to(player.global_position).x,
						0
					).normalized()
					turn_timer = 0.5
				velocity.x = move_direction.x * chase_speed
		states.STUN:
			$Star.visible = true
			$AnimationPlayer.play("Stun")
			if $StunTimer.is_stopped():
				$StunTimer.start(2.5)
			velocity.x = 0


func _on_PlayerDetector_player_changed():
	if weakref(player).get_ref():
		player_detect1 = false
		return
	else:
		player_detect1 = true
		return


func _on_StunTimer_timeout():
	state = states.WALK
	$StunTimer.stop()
	player = $PlayerDetector.player


func _on_PlayerDetectorExt_player_changed():
	if weakref(player).get_ref():
		player_detect2 = false
		Global.yield_wait(1)
		confusion_timer = .5
		player = null
		if move_direction.x < 0:
			move_direction = Vector2.LEFT
		else:
			move_direction = Vector2.RIGHT
	else:
		player_detect2 = true
		player = $PlayerDetectorExt.player
