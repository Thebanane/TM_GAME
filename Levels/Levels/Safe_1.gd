extends LevelParent

func _ready():
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false
	$AnimationPlayer2.play("entrance")


func _on_area_2d_2_body_entered(body):
	if body == $Player : 
		$Sprite2D.visible = true
		Global.Pop_can_show = true


func _on_area_2d_2_body_exited(_body):
	$Sprite2D.visible = false
	Global.Pop_can_show = false	
