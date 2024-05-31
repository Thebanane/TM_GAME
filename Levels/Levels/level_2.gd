extends LevelParent

func _ready():
	$Player/AudioStreamPlayer.play(Global.music_game_position)
	if Global.must_close :
		var tween = create_tween()
		tween.tween_property($Objects/Door_entrance,"position", Vector2(-82,-7), 0.2)
		Global.must_close = false
	else: 
		$Objects/Door_entrance.position = Vector2(-82,-7)



func _on_area_2d_2_body_entered(body):
	if body == $Player: 
		Global.level_time = 7.5
		Global.must_close = true
		Global.music_game_position = $Player/AudioStreamPlayer.get_playback_position()
		get_tree().change_scene_to_file("res://Levels/Levels/level_3.tscn")


func _on_death_zones_body_entered(body):
	if body == $Player : 
		Global.must_die = true


func _on_popup_body_entered(body):
	if body == $Player : 		
		$Sprite2D.visible = true
		Global.Pop_can_show = true
		

func _on_popup_body_exited(_body):
	$Sprite2D.visible = false
	Global.Pop_can_show = false


	




