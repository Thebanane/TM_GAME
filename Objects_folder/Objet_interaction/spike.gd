extends Node2D

var player_here: bool 

#Si le joueur touche la zone, on recharge la scène
func death():
	if player_here:
		get_tree().reload_current_scene()
		
func _process(_delta):
	death()


func _on_area_2d_body_entered(_body):
	player_here = true
