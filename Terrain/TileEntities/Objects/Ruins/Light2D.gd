extends Sprite

var s_destination
var s_scale
var s_energy
var destination
var end_scale
var end_energy

export var randomness = .2
export var speed = 4

func _ready():
	add_to_group('Lights')
	s_destination = position
	s_scale = scale
	s_energy = modulate.a
	update_rand_destinations()
	
func update_rand_destinations():
	destination = Vector2(s_destination.x + 10 * rand_range(-randomness, randomness), s_destination.y + 10 * rand_range(-randomness, randomness))
	var rvalue = rand_range(-randomness, randomness)
	end_scale = s_scale +  Vector2(rvalue, rvalue)
	end_energy = s_energy +  rand_range(-randomness, randomness)

func _process(delta):
	position = lerp(position, destination, speed * delta)
	scale.x = lerp(scale.x, end_scale.x, speed * delta)
	scale.y = lerp(scale.y, end_scale.y, speed * delta)
	modulate.a = lerp(modulate.a, end_energy, speed * delta) 
	
	if abs(end_energy) - abs(modulate.a) < 0.1:
		update_rand_destinations()
