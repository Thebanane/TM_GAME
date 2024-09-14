extends LevelParent

func _ready():
	
#Ici je dois flip le sprite du joueur sinon il regarde dans la mauvaise direction à l'entrée du jeu, ce qui n'est pas cohérent
	$AnimationPlayer.play("entrance")
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
	Global.can_move = false


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
		Global.timer_off = true
		$AnimationPlayer.play("level_5")


func _on_pop_up_body_entered(body):
	if body == $Player : 
		$Sprite2D.visible = true
		Global.Pop_can_show = true


func _on_pop_up_body_exited(_body):
	$Sprite2D.visible = false
	Global.Pop_can_show = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "level_5": 
		var level_5 = load("res://Levels/Levels/level_5.tscn")
		Global.level_time = 13.5
		Global.has_played_once = false
		get_tree().change_scene_to_packed(level_5)
	
	if anim_name == 'entrance' :
		Global.timer_off = false
		Global.can_move = true
			
		if not Global.has_played_once :
			$AnimationPlayer.play("door")
			Global.has_played_once = true
		else :
			$Objects/Door_entrance.position = Vector2(161,-6)
