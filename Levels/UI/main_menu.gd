extends Control




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://Levels/Levels/level_1.tscn")


func _on_quit_pressed():
	get_tree().quit()
