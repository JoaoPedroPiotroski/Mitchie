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
	#var music_volume = db2linear(ProjectSettings.get_setting('audio/music_volume'))
	$Tween.stop_all()
	$Tween.remove_all()
	if typeof(song) == TYPE_STRING:
		song = load(song)
	for player in mplayers:
		if player.stream != song:
			player.volume_db = linear2db(0)
			$Tween.interpolate_method(
				self,
				'set_linear_volume',
				0,
				1,
				speed_mult,
				Tween.TRANS_LINEAR,
				Tween.EASE_OUT
			)
			
			player.stream = song
			player.playing = true
	$Tween.start()

func stop_music():
	var music_volume = 1
	var target_vol = 0
	for player in mplayers:
		$Tween.interpolate_method(
				self,
				'set_linear_volume',
				music_volume,
				target_vol,
				0,
				Tween.TRANS_LINEAR
			)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	for player in mplayers:
		player.playing = false
		player.stream = null
		
func set_linear_volume(volume : float):
	for player in mplayers:
		player.volume_db = linear2db(volume)
	
func on_fx_ended(audio):
	for f in fx:
		if audio.name == f.name:
			f.playing = false


func _on_MusicPlayer_finished():
	mplayers[0].playing = true
	emit_signal('song_ended')
