extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if Input.is_action_just_pressed("action") and Global.dash_pop:
		pause()
	
	if not get_tree().paused: 
		$".".visible = false 

func pause(): 
	$".".visible = true
	get_tree().paused = true
