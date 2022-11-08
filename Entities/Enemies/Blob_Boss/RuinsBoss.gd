extends Enemy

enum States {
	SLEEP,
	WALK,
	CHASE,
	WHIRL,
	STUN
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

func _physics_process(delta):
	player = Global.player
	if !is_instance_valid(player):
		return
	velocity = move_direction * speed
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)
	
	match(ArmorState):
		ArmorStates.BROKEN:
			pass
		ArmorStates.WHOLE:
			pass
	
	match(State):
		States.SLEEP:
			pass
		States.WALK:
			pass
		States.CHASE:
			pass
		States.WHIRL:
			pass
		States.STUN:
			pass

func apply_damage(dmg, atk_pos = null):
	match(State):
		States.SLEEP:
			State = States.CHASE   

func _on_PlayerDetector_player_changed():
	if is_instance_valid($PlayerDetector.player):
		player_on_ground = true
	else:
		player_on_ground = false
		


