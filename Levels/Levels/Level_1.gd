#On dit que le level est une extension du code déja écrit dans LevelParent
extends LevelParent

func play_music():
	BackroungMusic.play_music_level()
	Global.can_move = true 

func _ready():
	Global.can_move = false
#Si c'est la première fois qu'on entre dans cette scène, on fait l'animation
	if not Global.has_played_once : 
		get_tree().paused = true
		$AnimationPlayer.play("Transition")

#Si ce n'est pas la première fois qu'on est sur cette scène (signifiant que le joueur est mort au moins une fois), je ne lance pas l'animation mais dois placer certains éléments à d'autres endroits pour que ça coincide avec la fin de l'animation
	else : 
		$Objects/Door_entrance.position = Vector2(192,446)
		$Front.color = Color('00000000')
		$CanvasLayer/Timer.modulate = Color('ffffff')
		$lights/Exit.visible = true
		$Player.visible = true
		$CanvasLayer/Timer.visible = true
		Global.can_move = true
		
#Lors le joueur entre dans cette zone, on passe à la scène suivant, c'est à dire le level 2.
#On initialise toutes les variables nécessaires et on lance la petite animation de transition de scène
func _on_area_2d_body_entered(body):
	if body == $Player : 
		Global.timer_off = true
		$AnimationPlayer.play("level_2")


#Afin de résoudre un soucis, j'ai décidé que lorque l'animation se termine, de ne pas directement passer à la scène suivant mais d'abords la charger puis aller. 
#Cela a résolu une partie du soucis (le rouge du chargement) mais il reste encore le problème d'affichage.
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Transition" :
		Global.has_played_once = true
		get_tree().paused = false	

	if anim_name == "level_2": 
		var level_2 = load("res://Levels/Levels/level_2.tscn")
		Global.level_time = 7.5
		Global.has_played_once = false
		get_tree().change_scene_to_packed(level_2)
