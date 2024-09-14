extends LevelParent
var popup: bool = false

#Lors de la première frame (seulement la première), on force l'image du joueur à tourner car sinon ce n'est pas cohérent que le joueur regarde le mur
func _ready():
	Global.timer_off = false
	Global.can_move = false
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
	$AnimationPlayer.play("entrance")


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
		Global.timer_off = true
		$AnimationPlayer.play("level_4")

#L'animation de la porte du début du niveau 
func _on_door_animation_body_entered(body):
	if body == $Player: 
		var tween1 = create_tween()
		tween1.tween_property($Player/Camera2D, "limit_top", 80, 0.3)  
		if not 	Global.has_played_once:
			var tween = create_tween()
			tween.tween_property($Objects/Door_entrance, "position", Vector2(0,90), 0.2)
			Global.has_played_once = true
		else :
			$Objects/Door_entrance.position = Vector2(0,90)


func _on_death_zones_body_entered(body):
	if body == $Player : 
		Global.must_die = true


func _on_area_2d_body_entered(body):
	if body == $Player : 
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
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "level_4":
		var level_4 = load("res://Levels/Levels/level_4.tscn")
		Global.level_time = 10.5
		Global.has_played_once = false
		get_tree().change_scene_to_packed(level_4)
	
	if anim_name == 'entrance' :
		Global.can_move = true
