extends Entity
class_name ItemDrop

export var item : String
var gravity = 300
var friction = 0.95
var bounce_friction = 0.6
export(String, FILE) var drop_sound
export(String, FILE) var collect_fx
var collided_last_frame = false

func _ready():
	set_physics_process(true)
	$AudioStreamPlayer2D.stream = load(drop_sound)
	if item == null:
		queue_free()
	else:
		$Sprite.texture = Inventory.get_item(item).icon
	
func _physics_process(delta):
	var kcollision = move_and_collide(velocity * delta, true, true, true)
	if weakref(kcollision).get_ref() and is_moving() and $dropsounddelay.is_stopped():
		velocity.y = -1 * abs(velocity.y * bounce_friction)
	velocity = move_and_slide(velocity)
	if weakref(kcollision).get_ref() and is_moving() and $dropsounddelay.is_stopped() and !collided_last_frame:
		$AudioStreamPlayer2D.playing = true
		$dropsounddelay.start(.5)
	if weakref(kcollision).get_ref():
		collided_last_frame = true
		print(kcollision.collider)
		print(collided_last_frame)
	else:
		collided_last_frame = false
	
	if !is_moving():
		set_physics_process(false)
	
	velocity.x *= friction
	velocity.y += gravity * delta

func setup(in_item=item, initial_velocity = Vector2.ZERO):
	item = in_item
	initial_velocity.y *= -1
	velocity = initial_velocity
	
func collect():
	Inventory.add_item_by_title(item, 1)
	AudioManager.play_fx(collect_fx)
	queue_free()


func _on_PlayerDetector_player_changed():
	collect()


func _on_dropsounddelay_timeout():
	$dropsounddelay.stop()


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.playing = false
