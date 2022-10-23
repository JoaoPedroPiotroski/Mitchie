extends PseudoEntity

func enable():
	$CollisionShape2D.disabled = false

func disable():
	$CollisionShape2D.disabled = true

export(int) var damage = 0
export(bool) var multilayer = false

func _on_AttackHitbox_body_entered(body):
	if body is Entity:
		var in_dir = get_parent().get_parent().get_parent().get_node("Directions").get_input_direction()
		body.apply_damage(damage, global_position)
		body._knockback(150, Vector2(in_dir.x, in_dir.y - .5))
	get_parent().get_parent().get_parent()._knockback(50, get_parent().get_parent().get_parent().get_node("Directions").get_input_direction() * -1)
	
