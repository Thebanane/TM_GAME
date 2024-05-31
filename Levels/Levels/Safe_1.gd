extends LevelParent

func _ready():
	$Player/AudioStreamPlayer.play(Global.music_game_position)
	$Player/Sprites_folder/girl_animation_sprites.flip_h = false


func _on_area_2d_2_body_entered(body):
	if body == $Player : 
		$Sprite2D.visible = true
		Global.Pop_can_show = true


func _on_area_2d_2_body_exited(_body):
	$Sprite2D.visible = false
	Global.Pop_can_show = false	
