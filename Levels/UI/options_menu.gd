extends Control


#Ici, je regarde d'abords dans quelle mode d'écran le joueur est afin d'afficher le bon nom dans la séléctions. Dans Godot, il y a 5 modes (1 = Windowed et 4 = Fullscreen)
func _ready():
	if DisplayServer.window_get_mode() == 4:
		$VBoxContainer/OptionButton.selected = 1
	else : 
		$VBoxContainer/OptionButton.selected = 0

	$VBoxContainer/OptionButton.grab_focus()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed('ui_down') or Input.is_action_just_pressed('ui_up'):
		$Tick_sound.play()

#Fonction qui va permettre de changer la taille de l'écrant
func _on_option_button_item_selected(index):
	if index == 0 : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)	


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
