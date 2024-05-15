extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if DisplayServer.window_get_mode() == 4:
		$VBoxContainer/OptionButton.selected = 1
	else : 
		$VBoxContainer/OptionButton.selected = 0
	
	$AudioStreamPlayer.play(Global.music_intro_position)
	$VBoxContainer/OptionButton.grab_focus()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass





func _on_option_button_item_selected(index):
	if index == 0 : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)	


func _on_quit_pressed():
	Global.music_intro_position = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
