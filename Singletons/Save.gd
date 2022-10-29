extends Node

var slot = 0
var just_loaded = false
var level = "Intro"
var entrance = 0
var max_health = 3
var max_mana = 3
var progress_flags = []
var inventory = []
var coins = 0

signal game_saved
signal game_loaded

func _input(_event):
	if Input.is_key_pressed(KEY_0):
		print('salvei')
		store_save()

func load_save(): 
	var save_game = File.new()
	while not save_game.file_exists("user://savegame" + str(slot) + ".save"):
		level = 'Intro'
		entrance = 0
		max_health = 3
		max_mana = 3
		progress_flags = []
		inventory = []
		coins = 0
		store_save()
		SceneManager.change_level(level) 
		just_loaded = true
		save_game.close()
	save_game.open("user://savegame" + str(slot) + ".save", File.READ)
	var save_data = parse_json(save_game.get_line())
	level = save_data['level']
	entrance = save_data['entrance']
	max_health = save_data['max_health']
	max_mana = save_data['max_mana']
	progress_flags = save_data['progress_flags']
	inventory = save_data['inventory']
	coins = save_data['coins']
	Inventory.coins = coins
	SceneManager.entrance = entrance
	SceneManager.change_level(level) 
	just_loaded = true
	emit_signal("game_loaded")
	save_game.close()
	
func store_save():
	inventory = Inventory.get_inventory()
	coins = Inventory.coins
	var save_dict = {
		'level' : level,
		'entrance' : entrance,
		'max_health' : max_health,
		'max_mana' : max_mana,
		'inventory' : inventory,
		'progress_flags' : progress_flags,
		'coins': coins
	}
	var save_game = File.new()
	save_game.open("user://savegame" + str(slot) + '.save', File.WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	while not save_game.file_exists("user://savegame" + str(slot) + ".save"):
		print('criando save')
	emit_signal("game_saved")
	
func add_progress_flag(flag : String):
	progress_flags.append(flag)
