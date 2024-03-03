extends Node2D


func _process(_delta):
	if Global.is_double_jumping: 
		$effects_animation.play("double_jump")
		Global.is_double_jumping = false
