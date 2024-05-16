extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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
	var tween = create_tween()
	tween.tween_property($front_screen,"color", Color(0,0,0), 2)
	await get_tree().create_timer(2.5).timeout
	get_tree().paused = false
	Global.music_intro_position = 0
	Global.music_game_position = 0 
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
