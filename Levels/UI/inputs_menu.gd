extends Control

# Même principe que le fichier credits.gd
func _ready():
	$VBoxContainer/Quit.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") :
		$Enter_sound.play()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
