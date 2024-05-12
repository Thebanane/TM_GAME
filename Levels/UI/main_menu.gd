extends Control

func _ready():
	$"VBoxContainer/New game".grab_focus()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_game_pressed():
	$Front_transion.visible = true
	var tween = create_tween()
	tween.tween_property($Front_transion,"color", Color(0, 0, 0), 2 )
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_file("res://Levels/UI/introduction.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_button_pressed():
	pass # Replace with function body.
