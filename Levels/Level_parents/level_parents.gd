extends Node2D
class_name LevelParent

func double_jump_effect():
	if Global.double_jump_input_pressed: 
		$Effects.global_position = $Player.global_position
		Global.double_jump_input_pressed = false
		Global.is_double_jumping = true

func death(parameter): 
	if parameter : 
		get_tree().reload_current_scene()
		parameter = false 


func _ready():
	pass
	
func _process(_delta):
	double_jump_effect()
	death(Global.is_dead)
