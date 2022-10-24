extends Node

onready var fx = $FX.get_children()
onready var mplayers = $Music.get_children() 

signal song_ended

var current_state = 'intro'

func _ready():
	for audio in fx:
		audio.connect('ended', self, 'on_fx_ended')

func play_fx(audio_path):
	var a = load(audio_path)
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
			
func play_song(song):
	for player in mplayers:
		if player.stream != song:
			player.stream = song
			player.playing = true
			return

func stop_music():
	for player in mplayers:
		player.playing = false
	
func on_fx_ended(audio):
	for f in fx:
		if audio.name == f.name:
			f.playing = false


func _on_MusicPlayer_finished():
	mplayers[0].playing = true
	emit_signal('song_ended')
