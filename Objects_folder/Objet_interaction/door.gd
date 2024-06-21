extends StaticBody2D
signal bodyhere

#Emettre un signal lorsque le joueur entre dans la zone qui le bloque
func _on_area_2d_body_entered(body):
	bodyhere.emit(body)
