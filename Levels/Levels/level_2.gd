extends LevelParent

func _ready():
#La solution que j'ai trouvé pour avoir la music qui se suit, c'est d'à chaque fois, prendre les coordonées de la musique avant le changement de scène et l'aplliquer à la nouvelle scène.	
	$AnimationPlayer.play("entrance_transition")



func _on_area_2d_2_body_entered(body):
	if body == $Player: 
		$AnimationPlayer.play("level_3")


func _on_death_zones_body_entered(body):
	if body == $Player : 
		Global.must_die = true

#Lorsque le joueur entre dans la zone où il peut voir la popup tuto, j'affiche le point d'exclamation mais également je dis à la varibale stocké dans global que le joueur est présent
func _on_popup_body_entered(body):
	if body == $Player : 		
		$Sprite2D.visible = true
		Global.Pop_can_show = true
		
#Lorsque le joueur quitte la zone, j'enlève toutes les variables qui étaient actives
func _on_popup_body_exited(_body):
	$Sprite2D.visible = false
	Global.Pop_can_show = false



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "level_3":
		var level_3 = load("res://Levels/Levels/level_3.tscn")
		Global.level_time = 8
		Global.has_played_once = false
		get_tree().change_scene_to_packed(level_3)
	
	if anim_name == "entrance_transition": 
		if not Global.has_played_once : 
			$AnimationPlayer.play("door")
			Global.has_played_once = true
		else :
			$Objects/Door_entrance.position = Vector2(-82,-7)
		
