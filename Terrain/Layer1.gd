extends Node2D


func _ready():
	Global.connect("player_layer_changed", self, "update_player_layer")

func update_player_layer():
	if Global.player_layer == 0:
		set_modulate(Color(1, 1, 1, 1))
	else:
		set_modulate(Color(1, 1, 1, 0.5))
