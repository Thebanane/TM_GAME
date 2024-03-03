extends LevelParent


func _on_area_2d_body_entered(body):
	if body == $Player : 
		get_tree().change_scene_to_file("res://Levels/Levels/level_2.tscn")
