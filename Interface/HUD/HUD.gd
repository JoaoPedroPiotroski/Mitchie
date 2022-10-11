extends Control

func _ready():
	var _c = Global.connect("player_updated", self, 'update_vis')
	yield(get_tree().create_timer(0.1), 'timeout')
	update_vis()
	
func update_vis():
	if Global.player != null:
		visible = true
	else:
		visible = false
