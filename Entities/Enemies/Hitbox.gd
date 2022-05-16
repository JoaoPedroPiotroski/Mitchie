extends Area2D

export(int) var damage = 0
export(bool) var multilayer = false
export(int, "Layer1", "Layer2") var layer

func _on_Hitbox_body_entered(body):
	if body is Entity:
		if body.layer == layer or multilayer == true:
			body.apply_damage(damage)
