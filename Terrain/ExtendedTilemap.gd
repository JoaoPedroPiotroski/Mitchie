extends TileMap
class_name ExtendedTilemap

export(String) var title 

func _ready():
	var thread = Thread.new()
	thread.start(TilesManager, 'prepare_me', self)
	#TilesManager.prepare_me(self)

