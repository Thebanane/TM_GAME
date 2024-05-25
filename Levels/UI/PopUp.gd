extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if Input.is_action_just_pressed("action") and Global.Pop_can_show:
		pause()
	
	if not get_tree().paused: 
		$".".visible = false 

func pause(): 
	$".".visible = true
	get_tree().paused = true
	



	

