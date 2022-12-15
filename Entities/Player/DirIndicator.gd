extends Line2D


var enemies = []

func _on_EnemyDetector_body_entered(body):
	enemies.append(body)
	visible = false

func _on_EnemyDetector_body_exited(body):
	enemies.erase(body)
	if enemies.size() <= 0:
		visible = false
