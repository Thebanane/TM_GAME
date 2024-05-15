extends LevelParent

func _ready():
	$AudioStreamPlayer.play(Global.music_game_position)
	var tween = create_tween()
	tween.tween_property($Objects/Door_entrance, "position", Vector2(177,-5), 0.2)
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
	


func _on_switch_switch_on():
	var tween = create_tween()
	tween.tween_property($Objects/Door_exit, "position", Vector2(-1086,584), 0.5)
	tween.tween_property($Objects/Door_exit, "position", Vector2(-1086,642.775), 2.1)


func _on_camera_change_body_entered(_body):
	var tween = create_tween()
	$Player/Camera2D.limit_top = 570
	$Player/Camera2D.limit_right = -385
	tween.tween_property($Player/Camera2D, "zoom",Vector2(1.8,1.8), 0.2)


func _on_camera_change_3_body_entered(_body):
	$Player/Camera2D.limit_bottom = 5


func _on_camera_change_2_body_entered(body):
	if body == $Player:
		$Player/Camera2D.limit_bottom = 100000000


func _on_door_bodyhere(body):
	if body == $Player:
		Global.must_die = true


func _on_level_change_body_entered(body):
	if body == $Player:
		Global.music_game_position = $AudioStreamPlayer.get_playback_position()
		get_tree().change_scene_to_file("res://Levels/Levels/safe_1.tscn")
