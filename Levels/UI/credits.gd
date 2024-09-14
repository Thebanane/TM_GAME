extends Control

#Lorsque la scène s'ouvre, je place la musique là où il s'était arrêter et je "grab" le bouton qui permet de quitter, donc d'aller au main menu.
#Cette dernière permet au manette de se mouvoir dans le menu. Si j'enlève se grab focus, il faudrait d'abords cliquer avec la souris pour qu'ensuite on puisse utiliser la manette, ce que je ne souhaite pas.
func _ready():
	$VBoxContainer/Quit.grab_focus()


#Lorsque le joueur quitte, je récupère les "coordonées" de ma musique pour ensuite la jouer au main menu au bonne endroit. 
func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
