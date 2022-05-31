extends Line2D


var enemies = []

func _on_EnemyDetector_body_entered(body):
	enemies.append(body)
	visible = true

func _on_EnemyDetector_body_exited(body):
	enemies.erase(body)
	if enemies.size() <= 0:
		visible = false
