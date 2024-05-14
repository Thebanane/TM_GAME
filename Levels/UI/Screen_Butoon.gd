extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	
	if DisplayServer.WINDOW_MODE_WINDOWED : 
		$".".selected = 1
	else : 
		$".".selected = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
 
	



		
