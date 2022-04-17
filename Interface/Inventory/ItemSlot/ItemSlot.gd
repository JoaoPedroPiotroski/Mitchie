extends Panel

var item : Item

signal clicked(item)

onready var popup_detail = $Detail

func start(in_item : Item):
	$TextureButton.texture_normal = in_item.icon
	item = in_item
	
func _ready(): 
	connect("clicked", Menu.get_node("PauseMenu"), "show_item_detail", [item])


func _on_TextureButton_pressed():
	emit_signal("clicked")
