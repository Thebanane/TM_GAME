extends Control

# Même principe que le fichier credits.gd
func _ready():
	$VBoxContainer/Quit.grab_focus()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
