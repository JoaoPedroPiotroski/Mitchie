extends Node

onready var fx = $FX.get_children()
onready var mplayers = $Music.get_children() 

signal song_ended

var song = ''
var current_state = 'intro'

func play_fx(audio_path):
	var a = load(audio_path)
	for audio in fx:
		if not audio.playing:
			audio.stream = a
			audio.playing = true
			return

func transition_music_to(new_song : String, transition_type = 'direct'):
	song = new_song
	if transition_type == 'direct':
		var found_music = false
		for player in mplayers:
			if player.playing:
				found_music = true
				player.stream = load(new_song)
		if not found_music:
			mplayers[0].stream = load(new_song)
			mplayers[0].playing = true

func stop_music():
	for player in mplayers:
		player.playing = false
	
func _on_MusicPlayer_finished():
	emit_signal("song_ended")
