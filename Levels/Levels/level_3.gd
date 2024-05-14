extends LevelParent

#Lors de la première frame (seulement la première), on force l'image du joueur à tourner car sinon ce n'est pas cohérent que le joueur regarde le mur
func _ready():
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
		Global.level_time = 7
		get_tree().change_scene_to_file("res://Levels/Levels/level_4.tscn")
		


func _on_door_animation_body_entered(body):
	if body == $Player: 
		var tween1 = create_tween()
		tween1.tween_property($Player/Camera2D, "limit_top", 80, 0.3)  
		var tween = create_tween()
		tween.tween_property($Objects/Door_entrance, "position", Vector2(0,90), 0.2)


func _on_death_zones_body_entered(body):
	if body == $Player : 
		Global.must_die = true
