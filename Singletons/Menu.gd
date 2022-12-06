extends CanvasLayer

signal transition_ended

func transition_start():
	$AnimationPlayer.play("transition")
	
func transition_end():
	yield(get_tree().create_timer(0.2), 'timeout')
	$AnimationPlayer.play_backwards("transition")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal('transition_ended')
	
func create_shop(path):
	var s = load("res://Interface/Shop/ShopInterface.tscn")
	var i = s.instance()
	i.start(load(path))
	add_child(i)
