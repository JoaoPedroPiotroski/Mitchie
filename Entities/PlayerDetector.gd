extends Area2D

var player = null

signal player_changed

func _on_PlayerDetector_body_entered(body):
	if body is Player:
		player = body
		emit_signal("player_changed")


func _on_PlayerDetector_body_exited(body):
	if body is Player:
		player = null
		emit_signal("player_changed")
		
func is_player_detected() -> bool: 
	return player != null
