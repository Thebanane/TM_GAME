extends LevelParent

func _ready():
	$Player/AudioStreamPlayer.play(Global.music_game_position )

	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
	if Global.must_close :
		var tween = create_tween()
		tween.tween_property($Objects/Door_entrance2,"position", Vector2(192,490), 0.5)
		Global.must_close = false
	else :
		$Objects/Door_entrance2.position = Vector2(192,490)
