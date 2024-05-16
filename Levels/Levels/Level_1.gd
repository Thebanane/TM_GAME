#On dit que le level est une extension du code déja écrit dans LevelParent
extends LevelParent

func _ready():
	get_tree().paused = true
	Global.level_time = 3
	$AnimationPlayer.play("Transition")
	await get_tree().create_timer(4.5).timeout
	get_tree().paused = false
	$Player/AudioStreamPlayer.play(0)

	


#Lors le joueur entre dans cette zone, on passe à la scène suivant, c'est à dire le level 2
func _on_area_2d_body_entered(body):
	if body == $Player : 
		Global.level_time = 4.5
		Global.music_game_position = $Player/AudioStreamPlayer.get_playback_position()
		get_tree().change_scene_to_file("res://Levels/Levels/level_2.tscn")
