#On dit que le level est une extension du code déja écrit dans LevelParent
extends LevelParent


#Lors le joueur entre dans cette zone, on passe à la scène suivant, c'est à dire le level 2
func _on_area_2d_body_entered(body):
	if body == $Player : 
		get_tree().change_scene_to_file("res://Levels/Levels/level_2.tscn")
