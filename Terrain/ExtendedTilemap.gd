extends TileMap
class_name ExtendedTilemap

export(String) var title 

func _ready():
	TilesManager.prepare_me(self)
	#TilesManager.prepare_me(self)

