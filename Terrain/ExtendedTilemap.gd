extends TileMap
class_name ExtendedTilemap

export(String) var title 
export(int, "Layer1", "Layer2") var layer = 0

func _ready():
	TilesManager.prepare_me(self)
