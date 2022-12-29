extends Node2D

var already_spawned = false

func _ready() -> void:
	pass

func spawn() -> void:
	var gloop_scene = load("res://Entities/Enemies/Gloop/Gloop.tscn")
	var eye_scene = load("res://Entities/Enemies/Eye/Eye.tscn")
	var particle_scene = load("res://Entities/SpawnSmoke.tscn")
	
	for gs in $GloopSpawns.get_children():
		var inst = gloop_scene.instance()
		get_parent().add_child(inst)
		inst.global_position = gs.global_position
		var smk = particle_scene.instance()
		get_parent().add_child(smk)
		smk.global_position = gs.global_position
		smk.emitting = true
	for es in $EyeSpawns.get_children():
		var inst = eye_scene.instance()
		get_parent().add_child(inst)
		inst.global_position = es.global_position
		var smk = particle_scene.instance()
		get_parent().add_child(smk)
		smk.global_position = es.global_position
		smk.emitting = true
	
	already_spawned = true

func _on_Trigger_body_entered(body: Node) -> void:
	if body is Player and not already_spawned:
		spawn()
