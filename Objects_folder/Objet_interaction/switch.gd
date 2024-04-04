extends Node2D
signal switch_on 

var is_player_here: bool = false

func switch():
	if is_player_here and Input.is_action_just_pressed("action"):
		$AnimationPlayer.play("on_off_animation")
		is_player_here = false 
		switch_on.emit()

func _process(_delta):
	switch()

func _on_area_2d_body_entered(body):
	is_player_here = true
	

