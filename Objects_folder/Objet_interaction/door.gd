extends StaticBody2D
signal bodyhere

func _on_area_2d_body_entered(body):
	bodyhere.emit(body)
