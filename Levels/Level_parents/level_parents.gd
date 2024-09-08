extends Node2D
#On désigne ce level comme le parent. 
class_name LevelParent

#Cette fonction permet de bien placer les effets de mouvement du joueur
func double_jump_effect():
	if Global.double_jump_input_pressed: 
		$Effects.global_position = $Player.global_position
		Global.double_jump_input_pressed = false
		Global.is_double_jumping = true

#Fonction qui va voir quelle mode le joueur a choisi et faire la mort qui le correspond		
func player_death():
	if Global.mode == 'normal' :
		if Global.must_die: 
			get_tree().reload_current_scene()
			Global.must_die = false
			$CanvasLayer/Front.visible = true
	elif Global.mode == 'hard':
		if Global.must_die: 
			get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
			Global.must_die = false
			$CanvasLayer/Front.visible = true


func _ready():
	Global.light = false
	$lights/DirectionalLight2D.color = Color('7b8397')
	
func _process(_delta):
	double_jump_effect()
	player_death()



