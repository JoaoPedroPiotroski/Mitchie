extends Resource
class_name item

export(int, "Milestone", "Use", "Consume", "Equip") var type = 0
export(String) var title : String
export(String) var description : String
export var icon : StreamTexture
export var scene : PackedScene
var amount = 0

enum types {
	milestone,
	use,
	consume,
	equip
}

func _ready():
	match(type):
		types.milestone:
			print("milestone")
		types.use:
			print("use")
		types.consume:
			print("consume")
		types.equip:
			print("equip")


