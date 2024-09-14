extends LevelParent

func _ready():
	$AnimationPlayer.play("entrance")
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
	Global.can_move = false


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
		Global.timer_off = true
		$AnimationPlayer.play("safe_1")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "safe_1":
		var safe = load("res://Levels/Levels/safe_1.tscn")
		Global.has_played_once = false
#La scène safe_1 a eu quelques soucis, c'est pour cela que je dois mettre un temps énorme pour pas que ça enclenche la mort sans raison
		Global.level_time = 9999999999999999
		get_tree().change_scene_to_packed(safe)
		
	if anim_name == 'entrance': 
		Global.timer_off = false
		if not Global.has_played_once :
			$AnimationPlayer.play("door")
			Global.has_played_once = true
		else :
			$Objects/Door_entrance.position = Vector2(177,-5)
		Global.can_move = true
