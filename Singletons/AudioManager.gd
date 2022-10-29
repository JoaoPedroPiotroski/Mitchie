extends Node

onready var fx = $FX.get_children()
onready var mplayers = $Music.get_children() 

signal song_ended

var current_state = 'intro'

func _ready():
	for audio in fx:
		audio.connect('ended', self, 'on_fx_ended')

func play_fx(audio_path):
	var a
	if typeof(audio_path) == TYPE_STRING:
		a = load(audio_path)
	else:
		a = audio_path
	for audio in fx:
		if not audio.playing:
			audio.stream = a
			audio.playing = true
			return

func transition_music_to(new_song : String, transition_type = 'direct'):
	if transition_type == 'direct':
		var found_music = false
		for player in mplayers:
			if player.playing:
				found_music = true
				player.stream = load(new_song)
		if not found_music:
			mplayers[0].stream = load(new_song)
			mplayers[0].playing = true
			
func play_song(song, speed_mult = 1):
	$Tween.stop_all()
	$Tween.remove_all()
	if typeof(song) == TYPE_STRING:
		song = load(song)
	for player in mplayers:
		if player.stream != song:
			player.volume_db = linear2db(0)
			$AnimationPlayer.play("fade_out", -1, speed_mult)
#			$Tween.interpolate_property(
#				player,
#				'volume_db',
#				target_vol,
#				music_volume,
#				5,
#				Tween.TRANS_LINEAR,
#				Tween.EASE_OUT
#			)
#			$Tween.start()
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play('fade_in', -1, speed_mult)
			player.stream = song
			player.playing = true
			return

func stop_music():
	var music_volume = ProjectSettings.get_setting('audio/music_volume') 
	var target_vol = linear2db(0.001)
	for player in mplayers:
		$Tween.interpolate_property(
				player,
				'volume_db',
				music_volume,
				target_vol,
				1,
				Tween.TRANS_LINEAR
			)
		$Tween.start()
		yield($Tween, "tween_all_completed")
		player.playing = false
		player.stream = null
	
func on_fx_ended(audio):
	for f in fx:
		if audio.name == f.name:
			f.playing = false


func _on_MusicPlayer_finished():
	mplayers[0].playing = true
	emit_signal('song_ended')
