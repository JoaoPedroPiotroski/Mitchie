extends PseudoEntity
class_name DialogTrigger

export(String) var timeline
export(Array, String) var requisites
export(Array, String) var deletabilities
export(bool) var autoplay = false

func _ready():
	for r in requisites:
		if !Save.progress_flags.has(r):
			queue_free()
	for d in deletabilities:
		if Save.progress_flags.has(d):
			queue_free()
	set_collision_layer_bit(0, false)
	set_collision_layer_bit(4, true)
	set_collision_mask_bit(0, false)
