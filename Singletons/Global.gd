extends Node

var player_layer : int setget set_player_layer
signal player_layer_changed 

# não tem como pegar os layers pelo nome, então aqui tem
# um dicionario pra fazer isso de um jeito meio feio

var mouse_position = Vector2.ZERO
var player
var current_level
var layers = {
	Layer1 = 0,
	Layer2 = 1,
	Player = 2,
	Enemy = 3,
	Interact = 4,
	Hitbox = 5,
	Hurtbox = 6
}

func set_player_layer(new_layer):
	player_layer = new_layer
	emit_signal("player_layer_changed")
	print('uwu')
	
func random_from_array(arr : Array):
	arr.shuffle()
	return arr[0]
	
