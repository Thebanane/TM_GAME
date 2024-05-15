extends LevelParent

func _ready():
	$AudioStreamPlayer2D.play(Global.music_game_position)
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
	var tween = create_tween()
	tween.tween_property($Objects/Door_entrance, "position", Vector2(161,-6), 0.2)

func _on_camera_change_body_entered(body):	
	if body == $Player :
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(2,2), 0.5)

#Lorsque on reçoit le signal (voir code spike), on fait bouger la porte et on modifie la limite de gauche de la caméra.
func _on_switch_switch_on():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($Objects/Door, "position", Vector2(-907,-21), 0.8)
	tween2.tween_property($Player/Camera2D,"limit_left", -1000, 0.8)


func _on_death_body_entered(body):
	if body == $Player: 
		Global.must_die = true


func _on_level_change_body_entered(body):
	if body == $Player: 
		Global.level_time = 9.5
		Global.music_game_position = $AudioStreamPlayer2D.get_playback_position()
		get_tree().change_scene_to_file("res://Levels/Levels/level_5.tscn")
