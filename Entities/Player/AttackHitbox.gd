extends PseudoEntity

func enable():
	$CollisionShape2D.disabled = false

func disable():
	$CollisionShape2D.disabled = true

export(int) var damage = 0
export(bool) var multilayer = false

func _on_AttackHitbox_body_entered(body):
	if body is Entity:
		body.apply_damage(damage)
		body._knockback(2000, global_position.direction_to(body.global_position))
