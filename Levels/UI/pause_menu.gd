extends Control


func _process(_delta):
	if Input.is_action_just_pressed("pause_menu") and get_tree().paused: 
		resume()		
	elif Input.is_action_just_pressed("pause_menu") and! get_tree().paused:
		pause()
		
		
#Fonction qui va mettre en pause tout le jeu et afficher l'écran de pause.	
func pause(): 
	get_tree().paused = true
	$".".visible = true
	$PanelContainer/VBoxContainer/Resume.grab_focus()
	if Input.is_action_just_pressed('ui_down') or Input.is_action_just_pressed('ui_up'):
		$Tick_sound.play()
	if Input.is_action_just_pressed("ui_accept") :
		$Enter_sound.play()

#Fonction qui resumer le jeu
func resume(): 
	get_tree().paused = false
	$".".visible = false

#Fonction qui relancer le niveau dans lequel on était	
func restart():
	resume()
	get_tree().reload_current_scene()
	


#Les boutons et les actions qu'ils doivent faire si on les appuie dessus
func _on_resume_pressed():
	resume()
	
func _on_restart_pressed():
	restart()

func _on_main_menu_pressed():
	$front_screen.visible = true
	$AnimationPlayer.play("transition")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "transition" :
		var main_menu = load("res://Levels/UI/main_menu.tscn")
		get_tree().change_scene_to_packed(main_menu)
