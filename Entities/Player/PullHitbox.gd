extends "res://Entities/Enemies/Hitbox.gd"

var pull_speed = .5 setget set_pull_speed
var player
var target

func set_pull_speed(new):
	pull_speed = new

func _ready():
	player = get_parent().get_parent().get_parent()
	
func enable():
	$CollisionShape2D.disabled = false

func disable(): 
	$CollisionShape2D.disabled = true

func _on_PullHitbox_body_entered(body):
	if body is Enemy and weakref(player):
		target = body
		player.next_animation = "Finish_Pull"
		$Tween.interpolate_property(target, 
		"global_position", 
		target.global_position, 
		player.global_position + (player.global_position.direction_to(target.global_position) * 30), 
		pull_speed, 
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()

func _on_PullHitbox_body_exited(body):
	if body == target:
		target = null
