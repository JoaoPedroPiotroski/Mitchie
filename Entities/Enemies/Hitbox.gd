extends Area2D

export(int) var damage = 0
export(float) var knockback_force = 0.0

func _on_Hitbox_body_entered(body):
	if body is Entity:
		body._knockback(knockback_force, global_position.direction_to(body.global_position))
		body.apply_damage(damage, global_position)
