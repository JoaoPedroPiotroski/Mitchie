extends Panel

var item : Resource

signal clicked(item)


func start(in_item : Resource):
	$TextureButton.texture_normal = in_item.icon
	item = in_item

func _ready(): 
	var c = connect("clicked", Menu.get_node("PauseMenu"), "show_item_detail", [item])


func _on_TextureButton_pressed():
	emit_signal("clicked")
