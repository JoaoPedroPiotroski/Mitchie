extends Node2D

onready var tgt_pos = $Position2D
onready var player_detector = get_parent().get_node("PlayerDetector")

signal shoot(player)

export var debug = false
var player = null
var origin : Transform2D

func _on_PlayerDetector_player_changed():
	if is_instance_valid(player_detector.player):
		player = player_detector.player
	else:
		if $Playerlosetimer.is_stopped():
			$Playerlosetimer.start(1)

func _ready():
	origin = global_transform
	set_physics_process(true)

func _physics_process(delta):
	if debug:
		update()
	if is_instance_valid(player):
		global_transform = player.global_transform
	else:
		global_transform = origin

func _draw():
	return
	draw_line(Vector2.ZERO, tgt_pos.position, Color.purple, 5)
	#draw_circle(Vector2.ZERO, 20, Color.red)


func _on_Timer_timeout() -> void:
	if is_instance_valid(player):
		emit_signal('shoot', player)


func _on_Playerlosetimer_timeout() -> void:
	if not is_instance_valid(player_detector.player):
		player = null
