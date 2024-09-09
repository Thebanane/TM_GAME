extends Control

@export var can_make_sound: bool = false

func skip(): 
	$AnimationPlayer.stop()
	$AnimationPlayer.play("skip")

func tick_sound(variable): 
	#Le son de mouvement 
	if variable :
		if Input.is_action_just_pressed('ui_down') or Input.is_action_just_pressed('ui_up'):
			$Tick_sound.play()

func _ready():
	$".".visible = false
	BackroungMusic.play_music_menu()
	if not Global.has_played_once : 
		$AnimationPlayer.play("Entrance")
		Global.has_played_once = true
	else : 
		skip()

func _process(_delta):
	if Input.is_action_just_pressed("jump") :
		skip()
	tick_sound(can_make_sound)

#Lorsque je suis sur le mode hardcore, le petit texte explicatif s'affiche
	if $VBoxContainer2/Hardcore.is_hovered() or $VBoxContainer2/Hardcore.has_focus() :
		$Label2.visible = true
	else : 
		$Label2.visible = false

#Le retour en arrière	
	if Input.is_action_just_pressed("ui_cancel"): 
		$AnimationPlayer.play("ReturnToMainMenu")

#L'affichage des mods de jeu
func _on_new_game_pressed():
	$AnimationPlayer.play("Transition1")

#Lorsque je veux quitter le jeu
func _on_quit_pressed():
	get_tree().quit()

#L'option
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Levels/UI/options.tscn")

#Les credits
func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Levels/UI/credits.tscn")

#Les controls
func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Levels/UI/inputs_menu.tscn")


#Si le mode choisi est normal, alors Global.mode = 'normal'	ce qui va me permettre dans le fichier de levelparent de définir la mort
func _on_peace_pressed():
	Global.mode = 'normal'	
	
	var tween = create_tween()	
	$AnimationPlayer.play("TransitionToGame")
	tween.tween_property(BackroungMusic, "volume_db", -60, 3.5)
	
	await get_tree().create_timer(3.5).timeout
	BackroungMusic.stop()
	get_tree().change_scene_to_file("res://Levels/UI/introduction.tscn")
	
#Si le mode choisi est normal, alors Global.mode = 'hard' ce qui va me permettre dans le fichier de levelparent de définir la mort	
func _on_hardcore_pressed():
	Global.mode = 'hard'
	
	var tween = create_tween()	
	$AnimationPlayer.play("TransitionToGame")
	tween.tween_property(BackroungMusic, "volume_db", -60, 3.5)
	
	await get_tree().create_timer(3.5).timeout
	BackroungMusic.stop()
	get_tree().change_scene_to_file("res://Levels/UI/introduction.tscn")
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Entrance" :
		can_make_sound = true
