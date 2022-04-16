extends Enemy

onready var bullet = preload("res://Entities/Enemies/Sniper/SniperBullet.tscn")
onready var player_detector = $PlayerDetector

var player = null

func spawn_bullet():
	var b = bullet.instance()
	b.start(global_position, global_position.angle_to(player.global_position), player.global_position, get_opposite_layer())
	get_parent().add_child(b)

func shoot():
	if is_instance_valid(player):
		spawn_bullet()

func _on_PlayerDetector_player_changed():
	player = player_detector.player

func _on_Timer_timeout():
	shoot()
