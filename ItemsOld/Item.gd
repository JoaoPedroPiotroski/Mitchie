extends Node

export(String) var nome = ""
export(String) var description = ""
export(bool) var stackable = false
export(bool) var equippable = false
export(StreamTexture) var icon 

func _equip_effect():
	pass

func _use(origin : Vector2, origin_layer):
	pass
