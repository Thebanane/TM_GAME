extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	show_popup()


func show_popup(): 
	if Input.is_action_just_pressed("action") and Global.Pop_can_show:
		$".".visible = true
		get_tree().paused = true
		
	
	if not get_tree().paused: 
		get_tree().paused = false
		$".".visible = false 


	



