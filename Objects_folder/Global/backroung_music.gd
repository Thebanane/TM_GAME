extends AudioStreamPlayer

const level_music = preload("res://Graphics/Music/EuropaIce Extended.wav")
const menu_music = preload("res://Graphics/Music/Pack/6- The Veil of Night.mp3")

func _play_music(music, sound) : 
	if stream == music: 
		return
	
	stream = music
	volume_db = sound
	play()
	
func play_music_level() :
	_play_music(level_music, -12)
	
func play_music_menu():
	_play_music(menu_music, -7)
