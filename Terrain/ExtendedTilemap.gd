extends TileMap
class_name ExtendedTilemap

export(String) var title 
export(int, "Layer1", "Layer2") var layer = 0

func update_layer():
	if layer == 0 and Global.player_layer != 0:
		modulate = Color('abd4d4d4')
	if layer == 0 and Global.player_layer == 0:
		modulate = Color(1,1,1,1)
	if layer == 1 and Global.player_layer != 1:
		modulate = Color('c4c0c7')
	if layer == 1 and Global.player_layer == 1:
		modulate = Color(1,1,1,1)
		

func _ready():
	TilesManager.prepare_me(self)
	Global.connect("player_layer_changed", self, 'update_layer') 
	update_layer()
	if layer == 1:
		global_position.y += 8
