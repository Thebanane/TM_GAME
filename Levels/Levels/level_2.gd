extends LevelParent

func _ready():
	var tween = create_tween()
	tween.tween_property($Objects/Door_entrance,"position", Vector2(-82,-7), 0.2)
	


#Si le joueur entre dans cette zone, on recharge la scène, et par conséquent le joueur se fait téléporter au début du niveau
func _on_area_2d_body_entered(body):
	if body == $Player:
		get_tree().reload_current_scene()


func _on_area_2d_2_body_entered(body):
	if body == $Player: 
		Global.level_time = 6.5
		get_tree().change_scene_to_file("res://Levels/Levels/level_3.tscn")


func _on_death_zones_body_entered(body):
	if body == $Player : 
		Global.must_die = true
