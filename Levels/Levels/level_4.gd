extends LevelParent

func _ready():
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
	var tween = create_tween()
	tween.tween_property($Objects/Door_entrance, "position", Vector2(161,-6), 0.2)

func _on_camera_change_body_entered(body):	
	if body == $Player :
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(2,2), 0.5)

#Lorsque on reçoit le signal (voir code spike), on fait bouger la porte et on modifie la limite de gauche de la caméra.
func _on_switch_switch_on():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($Objects/Door, "position", Vector2(-907,-21), 0.8)
	tween2.tween_property($Player/Camera2D,"limit_left", -1000, 0.8)


func _on_death_body_entered(body):
	if body == $Player: 
		get_tree().reload_current_scene()


func _on_level_change_body_entered(body):
	if body == $Player: 
		get_tree().change_scene_to_file("res://Levels/Levels/level_5.tscn")
