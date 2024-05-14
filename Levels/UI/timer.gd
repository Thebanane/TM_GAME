extends Label

var time
#Global.level_time
var timer_on = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	time = Global.level_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_on and time > 0.016:
		time -= delta
	else : 
		timer_on = false
		time = 0
		Global.must_die = true
			
		
	var sec = fmod(time,60)
	var mili = fmod(time,1) * 1000
	
	var time_passed = "%02d : %03d" % [sec,mili]
	text = time_passed
