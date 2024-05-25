extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property($Label,"modulate",Color('ffffff'),3)
	await get_tree().create_timer(4).timeout
	var tween2 = create_tween()
	tween2.tween_property($Label,"modulate",Color('ffffff00'),2)
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
