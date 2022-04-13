extends Node

var player_layer : int setget set_player_layer
signal player_layer_changed 

# não tem como pegar os layers pelo nome, então aqui tem
# um dicionario pra fazer isso de um jeito meio feio

var layers = {
	Layer1 = 0,
	Layer2 = 1,
	Player = 2,
	Enemy = 3,
	Interact = 4
}

func set_player_layer(new_layer):
	player_layer = new_layer
	emit_signal("player_layer_changed")
