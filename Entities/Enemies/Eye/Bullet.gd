extends "res://Entities/Enemies/Hitbox.gd"

export var update_debug_view : bool = false setget update_debug

var player
var visual_offset : Vector2 = Vector2.ZERO
var x_rising = true
var y_rising = true
var radius : int = 2
var max_radius : int = 10

func update_debug(_new_debug) -> void:
	update()
	update_debug_view = false

func start(pos, target):
	global_position = pos
	player = target

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return
	if y_rising:
		visual_offset.y +=delta * 4
	else:
		visual_offset.y -= delta * 4
	if x_rising:
		visual_offset.x += delta * 4
	else:
		visual_offset.x -= delta * 4
	if visual_offset.y > 1 or visual_offset.y < -1:
		y_rising = not y_rising
	if visual_offset.x > 1 or visual_offset.x < -1:
		x_rising = not x_rising
	visual_offset.x = rand_range(-.5, .5)
	visual_offset.y = rand_range(-.5, .5)
	update()
	var speed = 50 + (global_position.distance_to(player.global_position)+1) / 10
	global_position += global_position.direction_to(player.global_position) * speed * delta
	
func _draw() -> void:
	var red = Color.red
	var white = Color.white
	red.a = 0.5
	white.a = 0.8
	draw_circle(Vector2.ZERO + visual_offset, radius, red)
	draw_circle(Vector2.ZERO + -visual_offset, radius*0.9, white.blend(red))
	draw_circle(Vector2.ZERO + -visual_offset, radius*0.5, Color.white)

func _ready() -> void:
	var hitbox : CircleShape2D = CircleShape2D.new()
	hitbox.radius = 1
	$CollisionShape2D.shape = hitbox
	$Tween.interpolate_method(self, 
	'increase_radius', 
	radius, 
	max_radius, 
	3,Tween.TRANS_LINEAR,
	Tween.EASE_IN)
	$Tween.start()
	
func increase_radius(new_radius : int):
	radius = new_radius
	$CollisionShape2D.set_deferred('shape.radius', new_radius)

func die():
	var expl = load("res://Entities/Enemies/Eye/bullet_die.tscn")
	var e = expl.instance()
	e.start(global_position)
	get_parent().add_child(e)
	queue_free()

func _on_Lifetime_timeout() -> void:
	die()


func _on_Bullet_body_entered(body: Node) -> void:
	if body is Player:
		die()
