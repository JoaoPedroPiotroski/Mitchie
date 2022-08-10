extends Control

func _ready():
	var c = Global.connect("player_updated", self, 'update_vis')
	update_vis()
	
func update_vis():
	if Global.player != null:
		visible = true
	else:
		visible = false
