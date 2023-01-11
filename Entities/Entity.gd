extends KinematicBody2D

class_name Entity

# a qual das duas camadas a entidade pertence
export(int) var health = 1
export var collides_with_player = false
export var immortal = false
export var override_knockback = false

var velocity = Vector2.ZERO
var tween
var vis

func _ready():
	add_to_group("entities")
	hide()
	tween = Tween.new() 
	vis = VisibilityNotifier2D.new()
	add_child(vis)
	vis.connect("screen_entered", self, 'show')
	vis.connect("screen_exited", self, 'hide')
	add_child(tween)
	
func is_moving():
	if velocity.x < -0.1 or velocity.x > 0.1:
		return true
	if velocity.y < -0.1 or velocity.y > 0.1:
		return true
	return false
	
func update_health():
	if health <= 0 and !immortal: 
		_die()
	
func apply_damage(damage, _dealerpos = null, _args = []):
	health -= damage
	update_health()

func _die():
	queue_free()
	
func _knockback(force, dir):
	if override_knockback:
		return
	velocity = force * dir
	
