extends LevelParent
var popup: bool = false

#Lors de la première frame (seulement la première), on force l'image du joueur à tourner car sinon ce n'est pas cohérent que le joueur regarde le mur
func _ready():
	$Player/AudioStreamPlayer.play(Global.music_game_position )
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false




#Lorsque le joueur entre cette zonne, on va mettre de nouvelles valeurs à certaines variables mais surtout on va faire une petite animation. 
func _on_camera_body_entered(body):
	if body == $Player :
		$Player/Camera2D.limit_top = 630
		$Player/Camera2D.limit_smoothed = false
#JE DOIS ME RENSEIGNER SUR LES TWEEN
		var tween = create_tween()
#tween proprety doit contenir 4 variable: quelle élément, quelle variable de cette élément, que doit être les nouvelles valeurs, en combien de temps l'animation doit durer 
		tween.tween_property($Player/Camera2D, "zoom", Vector2(1.2,1.2), 0.5) 


func _on_camera_in_body_entered(body):
	if body == $Player : 
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(3.325,3.325), 0.5)


func _on_next_level_body_entered(body):
	if body == $Player : 
		Global.level_time = 6.5
		Global.must_close = true
		Global.music_game_position = $Player/AudioStreamPlayer.get_playback_position()
		get_tree().change_scene_to_file("res://Levels/Levels/level_4.tscn")
		


func _on_door_animation_body_entered(body):
	if body == $Player: 
		var tween1 = create_tween()
		tween1.tween_property($Player/Camera2D, "limit_top", 80, 0.3)  
		if Global.must_close :
			var tween = create_tween()
			tween.tween_property($Objects/Door_entrance, "position", Vector2(0,90), 0.2)
			Global.must_close = false
		else :
			$Objects/Door_entrance.position = Vector2(0,90)


func _on_death_zones_body_entered(body):
	if body == $Player : 
		Global.must_die = true



func _on_area_2d_body_entered(_body):
	$Sprite2D.visible = true
	Global.Pop_can_show = true	


func _on_area_2d_body_exited(_body):
	$Sprite2D.visible = false
	Global.Pop_can_show = false	


func _on_area_2d_2_body_entered(_body):
	$Sprite2D2.visible = true
	Global.dash_pop = true	


func _on_area_2d_2_body_exited(_body):
	$Sprite2D2.visible = false
	Global.dash_pop = false	
	


