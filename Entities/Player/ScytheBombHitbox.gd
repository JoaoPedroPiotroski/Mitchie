extends Area2D

export(int) var damage = 3

func _on_Hitbox_body_entered(body):
	if body is Entity:
		body.apply_damage(damage)
		body._knockback(80, global_position.direction_to(body.global_position))
