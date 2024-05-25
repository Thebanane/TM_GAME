extends LevelParent

func _ready():
	$Player/AudioStreamPlayer.play(Global.music_game_position)
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
