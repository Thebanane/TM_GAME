extends Control

func _ready():
	$AudioStreamPlayer.play(Global.music_intro_position)
	get_tree().paused = false
	if not Global.has_played_once : 
		var tween = create_tween()
		tween.tween_property($Label,"modulate",Color('ffffff'), 2)
		tween.tween_property($VBoxContainer,"modulate",Color('ffffff'), 2)
		Global.has_played_once = true
		await get_tree().create_timer(4).timeout
	else : 
		$VBoxContainer.modulate = Color('ffffff')
		$Label.modulate = Color('ffffff')
	

	$"VBoxContainer/New game".grab_focus()




func _process(_delta):
#Le son de mouvement 
	if Input.is_action_just_pressed('ui_down') or Input.is_action_just_pressed('ui_up'):
		$Tick_sound.play()
	if Input.is_action_just_pressed("ui_accept") :
		$Enter_sound.play()

#Lorsque je suis sur le mode hardcore, le petit texte explicatif s'affiche
	if $VBoxContainer2/Hardcore.is_hovered() or $VBoxContainer2/Hardcore.has_focus() :
		$Label2.visible = true
	else : 
		$Label2.visible = false

#Le retour en arrière	
	if Input.is_action_just_pressed("ui_cancel"): 
		$VBoxContainer.visible = true
		$VBoxContainer2. visible = false
		$"VBoxContainer/New game".grab_focus()

#L'affichage des mods de jeu
func _on_new_game_pressed():
	$VBoxContainer.visible = false
	$VBoxContainer2. visible = true
	$VBoxContainer2/Peace.grab_focus()

#Lorsque je veux quitter le jeu
func _on_quit_pressed():
	$Front_transion.visible = true
	var tween = create_tween()
	var tween2 = create_tween()
	tween2.tween_property($AudioStreamPlayer,"volume_db",-60, 2.5 )
	tween.tween_property($Front_transion,"color", Color(0, 0, 0), 1.5)
	$VBoxContainer.visible = false
	await get_tree().create_timer(2).timeout
	get_tree().quit()

#L'option
func _on_button_pressed():
	Global.music_intro_position = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://Levels/UI/options.tscn")

#Les credits
func _on_credits_pressed():
	Global.music_intro_position = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://Levels/UI/credits.tscn")

#Les controls
func _on_controls_pressed():
	Global.music_intro_position = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://Levels/UI/inputs_menu.tscn")


#Si le mode choisi est normal, alors Global.mode = 'normal'	ce qui va me permettre dans le fichier de levelparent de définir la mort
func _on_peace_pressed():
	Global.mode = 'normal'	
	$Front_transion.visible = true
	get_tree().paused = true
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($Front_transion,"color", Color(0, 0, 0), 2 )
	tween2.tween_property($AudioStreamPlayer,"volume_db",-60, 2.5 )
	$VBoxContainer2.visible = false
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_file("res://Levels/UI/introduction.tscn")
	
#Si le mode choisi est normal, alors Global.mode = 'hard' ce qui va me permettre dans le fichier de levelparent de définir la mort	
func _on_hardcore_pressed():
	Global.mode = 'hard'	
	$Front_transion.visible = true
	get_tree().paused = true
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($Front_transion,"color", Color(0, 0, 0), 2 )
	tween2.tween_property($AudioStreamPlayer,"volume_db",-60, 2.5 )
	$VBoxContainer2.visible = false
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_file("res://Levels/UI/introduction.tscn")
	


