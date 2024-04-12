extends LevelParent

func _ready():
	var tween = create_tween()
	tween.tween_property($Objects/Door_entrance,"position", Vector2(192,490), 0.5)
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
