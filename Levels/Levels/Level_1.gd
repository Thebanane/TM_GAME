#On dit que le level est une extension du code déja écrit dans LevelParent
extends LevelParent



func _ready():
	$AnimationPlayer.play("Transition")
	Global.level_time = 7
	
	
func _process(_delta):
	pass

#Lors le joueur entre dans cette zone, on passe à la scène suivant, c'est à dire le level 2
func _on_area_2d_body_entered(body):
	if body == $Player : 
		Global.level_time = 4.5
		get_tree().change_scene_to_file("res://Levels/Levels/level_2.tscn")
