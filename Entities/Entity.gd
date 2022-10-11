extends KinematicBody2D

class_name Entity

# a qual das duas camadas a entidade pertence
export(int) var health = 1
export var collides_with_player = false
export var immortal = false
export var override_knockback = false

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
	
func update_health():
	if health <= 0 and !immortal: 
		_die()
	
func apply_damage(damage):
	health -= damage
	update_health()

func _die():
	queue_free()
	
func _knockback(force, dir):
	tween.remove_all()
	if override_knockback:
		return
	tween.interpolate_property(self, 'global_position', global_position, global_position + (force * dir), .2)
	tween.start()
	
