extends LevelParent

func _ready():
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false

func _on_area_2d_body_entered(body):
	if body == $Player : 
		get_tree().reload_current_scene()


func _on_camera_body_entered(body):
	if body == $Player :
		$Player/Camera2D.limit_top = 630
		$Player/Camera2D.limit_smoothed = false
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(1.2,1.2), 0.5) 


func _on_camera_in_body_entered(body):
	if body == $Player : 
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(3.325,3.325), 0.5)


func _on_next_level_body_entered(body):
	if body == $Player : 
		get_tree().change_scene_to_file("res://Levels/Levels/level_4.tscn")
