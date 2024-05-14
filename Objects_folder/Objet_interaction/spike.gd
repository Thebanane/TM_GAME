extends Node2D

var player_here: bool 

#Si le joueur touche la zone, on recharge la scène
func death():
	if player_here:
		Global.must_die = true
		
func _process(_delta):
	death()


func _on_area_2d_body_entered(_body):
	player_here = true
