extends Enemy

var move_direction = Vector2.LEFT
var chase_speed = 65
var walk_speed = 30
enum states {
	WALK,
	STUN
}
var player = null
var sleeping = true

export(float) var gravity = 670.0
var wall_timer = .5
var wall_cd = false
var confusion_timer = 0
var floor_timer = .5
var floor_cd = false
var state = states.WALK
var tongue_timer = 0
var chase_timer = 0
var player_detect1 = false
var player_detect2 = false
var turn_timer = 0
var player_on_ground = false
var eye_spawn_positions = []
var crack_timer = 0.0
var dead = false
onready var tongue = $TongueLeft

func _ready() -> void:
	if Save.progress_flags.has('RuinsBossDefeated'):
		queue_free()
	eye_spawn_positions = get_parent().get_node("EyeSpawns").get_children()

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

func apply_damage(damage, dealerpos = null, args = []):
	if sleeping:
		sleeping = false
		$ZZZZ.emitting = false
		AudioManager.play_song("res://Music/Audio/AncientBoss.wav", 1)
		get_parent().get_node("LockedEntrance/CollisionShape2D").set_deferred('disabled', false) 
		get_parent().get_node("LockedEntrance").modulate = Color.white
		state = states.WALK
		return
	if dead:
		return
	print('tentaram me hitar aqui')
	if weakref(Global.player).get_ref():
		if does_player_hit(dealerpos) and args.has('player_explosion'):
			spawn_eye()
			print('levei um hit explosivo :3')
			$HitFlash.play("flash")
			AudioManager.play_fx("res://Entities/Enemies/Gloop/hurt.sfxr")
			health -= damage
			crack_timer = 0.1
			state = states.WALK
			confusion_timer = 0.3
			print('vida: ' + String(health))
		else:
			state = states.STUN
			$AnimationPlayer.play("Stun")
			$StunTimer.start(2.5)
	if health <= 0 and !immortal:
		$AnimationPlayer.play('Die')
		golden_shower()
		$Hitbox/CollisionShape2D2.set_deferred('disabled', true)    
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

func activate_tongue() -> void:
	if state == states.STUN:
		return
	
	if move_direction.x < 0:
		tongue = $TongueLeft
	else:
		tongue = $TongueRight
	tongue.get_node("CollisionShape2D2").set_deferred('disabled', false)
	tongue.visible = true

func deactivate_tongue() -> void:
	tongue_timer = 0
	tongue.get_node("CollisionShape2D2").set_deferred('disabled', true)
	tongue.visible = false
	#$AnimationPlayer.play("Chase")

func _physics_process(delta):
	$Star.visible = state == states.STUN
	if crack_timer > 0:
		$body.frame = 2
	crack_timer -= delta
	tongue_timer += delta
	eye_spawn_positions.shuffle()
	if $AnimationPlayer.current_animation == 'tongue':
		return
	if dead or sleeping:
		return
	
	#$PlayerDetectorExt/CollisionShape2D.set_deferred('disabled', !(player_detect2 or player_detect1))
	#FUNÇOES DE TESTE
	turn_timer -= delta
	
	wall_timer -= delta
	if wall_timer <= 0:
		wall_cd = false
	floor_timer -= delta
	if floor_timer <= 0:
		floor_cd = false
	velocity.y += gravity * delta
	confusion_timer -= delta
	if confusion_timer < 0:
		velocity = move_and_slide(velocity)
	else:
		velocity.x = 0
		velocity = move_and_slide(velocity)
	velocity.y += gravity * delta
	match(state):
		states.WALK:
			if move_direction.x < 0 and $AnimationPlayer.current_animation != 'walk_left':
				$AnimationPlayer.play("walk_left")
			elif move_direction.x > 0 and $AnimationPlayer.current_animation != 'walk_right':
				$AnimationPlayer.play('walk_right')
			#$Star.visible = false
			if not player_on_ground:
				velocity.x = move_direction.x * walk_speed
				if wall_detector():
					move_direction *= -1
				if floor_detector():
					move_direction *= -1
			else:
				
				if global_position.distance_to(player.global_position) < 100 and tongue_timer > 3:
					move_direction.x = global_position.direction_to(player.global_position).x
					velocity.x = 0
					$Sprite.flip_h = move_direction.x > 0
					if move_direction.x < 0 and $AnimationPlayer.current_animation != 'walk_left':
						$AnimationPlayer.play("walk_left")
					elif move_direction.x > 0 and $AnimationPlayer.current_animation != 'walk_right':
						$AnimationPlayer.play('walk_right')
					yield(get_tree().create_timer(0.01),"timeout")
					$AnimationPlayer.play('tongue')
					return
				if turn_timer < 0:
					move_direction = Vector2(
						global_position.direction_to(player.global_position).x,
						0
					).normalized()
					turn_timer = 0.5
				velocity.x = move_direction.x * chase_speed
		states.STUN:
			
			$PlayerDetector/CollisionShape2D.set_deferred('disabled', true)
			#$PlayerDetectorExt/CollisionShape2D.set_deferred('disabled', true)
			#$Star.visible = true
			$AnimationPlayer.play("Stun")
			velocity.x = 0


func _on_PlayerDetector_player_changed():
	if weakref(player).get_ref():
		#player_detect1 = false
		return
	else:
		player_detect1 = true
		player = $PlayerDetector.player
		return


func _on_StunTimer_timeout():
	state = states.WALK
	$StunTimer.stop()
	#player = $PlayerDetector.player
	$PlayerDetector/CollisionShape2D.set_deferred('disabled', false)
	#$PlayerDetectorExt/CollisionShape2D.set_deferred('disabled', false)


func _on_PlayerDetectorExt_player_changed():
	if weakref(player).get_ref():
		return
	else:
		player_detect2 = true
		player = $PlayerDetectorExt.player


func _on_OomfTimer_timeout():
	if state == states.STUN:
		$OomfTimer.start(.3)
		return
	else:
		if !weakref(player).get_ref():
			$AudioStreamPlayer2D.stream = load("res://Entities/Enemies/Gloop/ooooooom.sfxr")
			$AudioStreamPlayer2D.play()
		else:
			$AudioStreamPlayer2D.stream = load("res://Entities/Enemies/Gloop/Oomf.sfxr")
			$AudioStreamPlayer2D.play()
	
	if weakref(player).get_ref():
		$OomfTimer.start(.3)
	else:
		$OomfTimer.start(1.2)


func _on_PlayerGroundDetector_player_changed() -> void:
	if dead:
		return
	if weakref($PlayerGroundDetector.player).get_ref():
		player_on_ground = true
		$PlayerOnTopTimer.stop()
	else:
		player_on_ground = false
		$PlayerOnTopTimer.start(6)

func spawn_eye():
	var eye_scene = load("res://Entities/Enemies/Eye/Eye.tscn")
	var ins = eye_scene.instance()
	var pos = eye_spawn_positions[0].global_position
	get_parent().call_deferred('add_child', ins)
	ins.global_position = pos
	var particle_scene = load("res://Entities/SpawnSmoke.tscn")
	var smk = particle_scene.instance()
	get_parent().call_deferred('add_child', smk)
	smk.global_position = eye_spawn_positions[0].global_position
	smk.emitting = true

func open_doors():
	Save.add_progress_flag('RuinsBossDefeated')
	AudioManager.play_song("res://Music/Audio/AncientTemple.wav", 3)
	_die()
	get_parent().get_node("LockedEntrance/CollisionShape2D").set_deferred('disabled', true) 
	get_parent().get_node("LockedEntrance").modulate = Color("5e5e5e")
	get_parent().get_node("LockedExit/CollisionShape2D").set_deferred('disabled', true) 
	get_parent().get_node("LockedExit").modulate = Color("5e5e5e")

func _on_PlayerOnTopTimer_timeout() -> void:
	if not player_on_ground and not dead and not sleeping:
		spawn_eye()
