extends Node2D
signal switch_on 

var is_player_here: bool = false

#Pour le switch, il faut deux condistion avant d'envoyer le signal pour faire bouger qqch. Premièrement, est ce que le joueur est proche de l'interrupteur et est_ce qu'il touche la
#bonne touche. Si les deux conditions sont accéptées, alors on fait une animation et on envoie un signal. 
func switch():
	if is_player_here and Input.is_action_just_pressed("action"):
		$AnimationPlayer.play("on_off_animation")
		is_player_here = false 
		switch_on.emit()

func _process(_delta):
	switch()

func _on_area_2d_body_entered(_body):
	is_player_here = true

func _on_area_2d_body_exited(_body):
	is_player_here = false
