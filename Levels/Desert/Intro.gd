extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pics = [
	"res://ASeprite/intro1.png", "res://ASeprite/intro2.png", "res://ASeprite/intro3.png", "res://ASeprite/intro4.png", "res://ASeprite/intro5.png", "res://ASeprite/intro6.png",
	"res://ASeprite/intro65.png", "res://ASeprite/intro7.png"
]
var current = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = load(pics[current])
	AudioManager.stop_music()
	var d = Dialogic.new()
	d = d.start('intro')
	d.connect('dialogic_signal', self, '_next_pic')
	add_child(d)
	
	

func _next_pic():
	current += 1
	$Sprite.texture = load(pics[current])
