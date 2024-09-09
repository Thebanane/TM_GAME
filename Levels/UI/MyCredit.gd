extends Control

func skip(): 
	if Input.is_action_just_pressed("jump"): 
		get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")

#Animation de lancement de mon jeu avec mon nom
func _ready():
	$AnimationPlayer.play("Entrance")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'Entrance' : 
		get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")


func _process(_delta):
	if $AnimationPlayer.is_playing(): 
		skip()
