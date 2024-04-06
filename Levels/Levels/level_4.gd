extends LevelParent

func _ready():
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false

func _on_camera_change_body_entered(body):
	if body == $Player :
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(2,2), 0.5)


func _on_camera_change_2_body_entered(body):
	if body == $Player :
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(3.325,3.325), 0.3)


func _on_switch_switch_on():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($Objects/Door, "position", Vector2(-906,37.66), 1)
	tween2.tween_property($Player/Camera2D,"limit_left", -1060, 1)
