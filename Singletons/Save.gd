extends Node

var slot = 0
var level = "RuinsR3"
var max_health = 3
var max_mana = 3
var inventory = []
 


func load_save(_s): 
	SceneManager.change_level(level) 
	
func store_save(_s):
	pass
