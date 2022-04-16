extends Node2D


func _ready():
	var plc_con = Global.connect("player_layer_changed", self, "update_player_layer")

func update_player_layer():
	# Deixa translúcido quando o jogador está em outra layer
	if Global.player_layer != 1:
		set_modulate(Color(0.8, 0.8, 0.8, 1))
	else:
		set_modulate(Color(1, 1, 1, 1))
		
