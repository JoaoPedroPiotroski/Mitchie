extends Label

func _ready():
	var coin_amt = Inventory.coins
	text = "x " + str(coin_amt)

func _process(_delta):
	var coin_amt = Inventory.coins
	
	text = "x " + str(coin_amt)
	if coin_amt == 0:
		text = "x 000"
