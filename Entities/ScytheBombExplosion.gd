extends PseudoEntity


export(PackedScene) var particle

func _ready():
	$Hitbox.set_meta('player_attack', true)
	$Hitbox.set_meta('player_explosion', true)
	var p = particle.instance()
	get_parent().add_child(p)
	p.global_position = global_position
	p.emitting = true
	p.z_index = z_index
	
	
func start(pos):
	global_position = pos


func _on_Lifetime_timeout():
	queue_free()

func _on_Hitbox_body_entered(_body):
	queue_free()
