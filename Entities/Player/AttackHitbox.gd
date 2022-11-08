extends PseudoEntity

var swingsounds = [
	"res://Entities/Player/attacks/swing2.wav", "res://Entities/Player/attacks/swing3.wav", "res://Entities/Player/attacks/swing.wav"
]

var hitsounds = [
	"res://Entities/Player/attacks/sword_clash.5.ogg", "res://Entities/Player/attacks/sword_clash.9.ogg", "res://Entities/Player/attacks/sword_clash.10.ogg"
]

onready var player = get_parent().get_parent().get_parent()

func _ready():
	set_meta('player_attack1', true)
	set_meta('player_attack', true)

func enable():
	$CollisionShape2D.disabled = false
	swingsounds.shuffle()
	hitsounds.shuffle()
	AudioManager.play_fx(swingsounds[0])

func disable():
	$CollisionShape2D.disabled = true

export(int) var damage = 0
export(bool) var multilayer = false

func _on_AttackHitbox_body_entered(body):
	if body is Entity:
		if rand_range(0, 100) < 30:
			player.current.mana += 1
		AudioManager.play_fx(hitsounds[0])
		var in_dir = get_parent().get_parent().get_parent().get_node("Directions").get_input_direction()
		body.apply_damage(damage, global_position)
		body._knockback(150, Vector2(in_dir.x, in_dir.y - .5))
	get_parent().get_parent().get_parent()._knockback(50, get_parent().get_parent().get_parent().get_node("Directions").get_input_direction() * -1)
	
