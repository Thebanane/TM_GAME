extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause_menu") and get_tree().paused: 
		resume()		
	elif Input.is_action_just_pressed("pause_menu") and! get_tree().paused:
		pause()
	
func pause(): 
	get_tree().paused = true
	$".".visible = true
	$PanelContainer/VBoxContainer/Resume.grab_focus()
	if Input.is_action_just_pressed('ui_down') or Input.is_action_just_pressed('ui_up'):
		$Tick_sound.play()
	if Input.is_action_just_pressed("ui_accept") :
		$Enter_sound.play()

func resume(): 
	get_tree().paused = false
	$".".visible = false
	
func restart():
	resume()
	get_tree().reload_current_scene()
	

func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	restart()


func _on_main_menu_pressed():
	$front_screen.visible = true
	$AnimationPlayer.play("transition")




func _on_animation_player_animation_finished(anim_name):
	if anim_name == "transition" :
#		get_tree().paused = false
#		Global.music_intro_position = 0
#		Global.music_game_position = 0 
#		$PanelContainer/VBoxContainer.visible = false
		var main_menu = load("res://Levels/UI/main_menu.tscn")
		get_tree().change_scene_to_packed(main_menu)
