extends LevelParent


func _on_area_2d_body_entered(body):
	if body == $Player:
		get_tree().reload_current_scene()


func _on_area_2d_2_body_entered(body):
	if body == $Player: 
		get_tree().change_scene_to_file("res://Levels/Levels/level_3.tscn")
