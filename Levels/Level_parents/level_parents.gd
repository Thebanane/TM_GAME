extends Node2D
#On désigne ce level comme le parent. 
class_name LevelParent

#Cette fonction permet de bien placer les effets de mouvement du joueur
func double_jump_effect():
	if Global.double_jump_input_pressed: 
		$Effects.global_position = $Player.global_position
		Global.double_jump_input_pressed = false
		Global.is_double_jumping = true

func _ready():
	pass
	
func _process(_delta):
	double_jump_effect()
