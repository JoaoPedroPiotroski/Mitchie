extends AudioStreamPlayer

signal ended(player) 




func _on_FXPlayer1_finished():
	emit_signal("ended", self)
