extends Node
class_name TilesManager
	
static func prepare_me(tmap):
	var existing_tile_entities = get_existing_tile_entities()
	for tile_entity in existing_tile_entities:
		if tile_entity.tilemap == tmap.title:
			for t in tmap.get_used_cells_by_id(tile_entity.id):
				var new_entity = tile_entity.scene.instance()
				var tilepos = tmap.map_to_world(t)
				new_entity.global_position = tilepos
				tmap.add_child(new_entity)
				tmap.set_cell(t.x, t.y, -1)
			
static func get_existing_tile_entities():
	var dir = Directory.new()
	var existing_tile_entities = []
	var path = "res://Terrain/TileEntities/Resources/"
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				existing_tile_entities.append(load(path+file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return existing_tile_entities
