extends Light2D

var s_destination
var s_scale
var s_energy
var destination
var end_scale
var end_energy

export var randomness = .3
export var speed = 8

func _ready():
	add_to_group('Lights')
	s_destination = position
	s_scale = texture_scale
	s_energy = energy
	update_rand_destinations()
	
func update_rand_destinations():
	destination = Vector2(s_destination.x + 10 * rand_range(-randomness, randomness), s_destination.y + 10 * rand_range(-randomness, randomness))
	end_scale = s_scale +  rand_range(-randomness, randomness)
	end_energy = s_energy +  rand_range(-randomness, randomness)

func _process(delta):
	position = lerp(position, destination, speed * delta)
	texture_scale = lerp(texture_scale, end_scale, speed * delta)
	energy = lerp(energy, end_energy, speed * delta) 
	
	if abs(end_energy) - abs(energy) < 0.1:
		update_rand_destinations()
