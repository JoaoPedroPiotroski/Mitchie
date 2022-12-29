extends TextureRect


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"




func _on_Scythebombicon_visibility_changed() -> void:
	visible = Inventory.has_item("encantamento_fogo")


func _on_ItemsGrid_visibility_changed() -> void:
	visible = Inventory.has_item("encantamento_fogo")
