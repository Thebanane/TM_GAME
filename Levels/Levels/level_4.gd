extends LevelParent



func _on_camera_change_body_entered(body):
	if body == $Player :
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(2,2), 0.3)
		


func _on_camera_change_2_body_entered(body):
	if body == $Player :
		var tween = create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(3.325,3.325), 0.3)


func _on_switch_switch_on():
	var tween = create_tween()
	tween.tween_property($test, "position", Vector2(0,-48.225), 1)
