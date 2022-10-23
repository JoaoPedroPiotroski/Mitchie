extends Node

var player_layer : int setget set_player_layer
signal player_layer_changed 
signal player_updated

# não tem como pegar os layers pelo nome, então aqui tem
# um dicionario pra fazer isso de um jeito meio feio

var current_player_health = 0
var current_player_mana = 0
var mouse_position = Vector2.ZERO
var player setget set_player,get_player
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
var lights = false

func _input(_event):
	if Input.is_key_pressed(KEY_U):
		SceneManager.change_level('main_menu')

func _ready():
	if OS.has_feature('editor'):
		ProjectSettings.set_setting("application/config/project_settings_override", "")
	else:
		ProjectSettings.set_setting("application/config/project_settings_override", "user://mitchie_settings.godot")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Music'), ProjectSettings.get_setting('audio/music_volume'))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Effects'), ProjectSettings.get_setting('audio/fx_volume'))

func set_player_layer(new_layer):
	player_layer = new_layer
	emit_signal("player_layer_changed")
	print('uwu')
	
func set_player(new_player):
	player = new_player
	emit_signal('player_updated')
	
func get_player():
	if SceneManager.level.type == "Menu":
		return null
	return player
	
func random_from_array(arr : Array):
	arr.shuffle()
	return arr[0]
	
