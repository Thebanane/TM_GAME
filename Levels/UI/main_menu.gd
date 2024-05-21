extends Control

func _ready():
	if Global.must_close:
		var tween = create_tween()
		tween.tween_property($".","modulate",Color('ffffff'),2)
		Global.must_close = false
	else :
		$".".modulate = Color('ffffff')
	
	
	$"VBoxContainer/New game".grab_focus()
	$AudioStreamPlayer.play(Global.music_intro_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed('ui_down') or Input.is_action_just_pressed('ui_up'):
		$Tick_sound.play()
	if Input.is_action_just_pressed("ui_accept") :
		$Enter_sound.play()


func _on_new_game_pressed():
	$Front_transion.visible = true
	get_tree().paused = true
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($Front_transion,"color", Color(0, 0, 0), 2 )
	tween2.tween_property($AudioStreamPlayer,"volume_db",-60, 2.5 )
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_file("res://Levels/UI/introduction.tscn")


func _on_quit_pressed():
	$Front_transion.visible = true
	var tween = create_tween()
	var tween2 = create_tween()
	tween2.tween_property($AudioStreamPlayer,"volume_db",-60, 2.5 )
	tween.tween_property($Front_transion,"color", Color(0, 0, 0), 1.5)
	await get_tree().create_timer(2).timeout
	get_tree().quit()


func _on_button_pressed():
	Global.music_intro_position = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://Levels/UI/options.tscn")


func _on_credits_pressed():
	Global.music_intro_position = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://Levels/UI/credits.tscn")
