extends PseudoEntity



func _ready():
	$Hitbox.set_meta('player_attack', true)
	$Hitbox.set_meta('player_explosion', true)
	
func start():
	$Hitbox/CollisionShape2D.set_deferred('disabled', false)


func _on_Lifetime_timeout():
	$Hitbox/CollisionShape2D.set_deferred('disabled', true)

func _on_Hitbox_body_entered(_body):
	$Hitbox/CollisionShape2D.set_deferred('disabled', true)
