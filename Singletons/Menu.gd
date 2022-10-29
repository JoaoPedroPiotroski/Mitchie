extends CanvasLayer

signal transition_ended

func transition_start():
	$AnimationPlayer.play("transition")
	
func transition_end():
	$AnimationPlayer.play_backwards("transition")


func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal('transition_ended')
