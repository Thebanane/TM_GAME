#On dit que le level est une extension du code déja écrit dans LevelParent
extends LevelParent

func _ready():
	Global.has_played_once = false
	Global.level_time = 3
	if Global.must_close : 
		get_tree().paused = true
		$AnimationPlayer.play("Transition")
		Global.must_close = false
		await get_tree().create_timer(4.5).timeout
		get_tree().paused = false
	else : 
		$Objects/Door_entrance.position = Vector2(192,446)
		$Front.color = Color('00000000')
		$CanvasLayer/Timer.modulate = Color('ffffff')
		$lights/Exit.visible = true
	
	$Player/AudioStreamPlayer.play(Global.music_game_position)

	


#Lors le joueur entre dans cette zone, on passe à la scène suivant, c'est à dire le level 2
func _on_area_2d_body_entered(body):
	if body == $Player : 
		Global.level_time = 5.5
		Global.music_game_position = $Player/AudioStreamPlayer.get_playback_position()
		Global.must_close = true
		get_tree().change_scene_to_file("res://Levels/Levels/level_2.tscn")
