extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Save.progress_flags.has('RuinsBossDefeated'):
		get_parent().get_node("LockedEntrance/CollisionShape2D").set_deferred('disabled', true) 
		get_parent().get_node("LockedEntrance").modulate = Color("5e5e5e")
		get_parent().get_node("LockedExit/CollisionShape2D").set_deferred('disabled', true) 
		get_parent().get_node("LockedExit").modulate = Color("5e5e5e")
