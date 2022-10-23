extends Node2D

var coins = []

func start(minimum, maximum, pos):
	var c = preload("res://Levels/ItemsOld/Drop/ItemDrop.tscn")
	for i in range(randi() % maximum + minimum):
		var d = c.instance()
		d.setup('Coin', Vector2(rand_range(-150, 150), rand_range(100, 150))) 
		d.global_position = pos
		coins.append(d)
	for d in coins:
		get_parent().call_deferred('add_child', d)
		
