extends CharacterBody2D

#variable vitesse (@export signifie qu'on place la variable dans l'inspecteur pour pouvoir modifer sans rouvrir le script)
@export var speed = 350

#variables utilisées dans la fonction movement_dash
var dashspeed
var dashing = false
var can_dash = true
var dash_direction: Vector2 = Vector2.ZERO

#variables qui détérminera le déplacement du joueur
@export var target_velocity = Vector2.ZERO

#variables utilisées dans la fonction jump et qui déterminera la puissance du saut et de la gravité
@export var gravity = 35
@export var jump_impulse = 450
var can_double_jump: bool = false
var can_jump : bool

#variable utilisée dans la fonction wall_slide et qui va déterminer la vitesse de glissement
@export var wall_gravity = 20

#variable utilisée dans la fonction floor_slide
var is_floor_slide : bool = false

#variables utilies lors de l'animation du personnage
@export var is_jumping = false


	
#la fonction movement_dash va faire bouger le joueur. Le dash doit également faire partie de la fonction car sinon deux mouvements pourraient se superposer et l'un d'entre eux va pas pouvoir fonctionner
#Cette fonction a deux paramètres : direction est pour avoir les coordonées x et y tandis que axis donne que les coordonées x. Pour plus d'explication, allez voir la fonction _process
func movement_dash(parameter_direction, parameter_axis):

#Si on est apte a pouvoir dash, qu'on appuie le bouton pour dasher et que le joueur bouge au moins dans un sens, alors on dit que le joueur est en train de dasher et on sauvegarde la dernière direction
#du joueur, comme ça le joueur ne peut changer de direction durant le dash. De plus, on active un chronomètre pour arrêter le dash au bout d'un certain temps, sinon il fera le dash continuellement. 
	if Input.is_action_just_pressed("dash") and can_dash and! parameter_direction == Vector2(0,0):
		dashing = true
		dash_direction = round(parameter_direction)
		$dash_stop.start()	

#Lors du dash, on modifie la valeur de la vitesse de base du déplacement. On aura alors une sensation de dash.
	if dashing:
		if dash_direction == Vector2(0,-1) or dash_direction == Vector2(0,1):
			speed = 400
		elif dash_direction == Vector2(1,0) or dash_direction == Vector2(-1,0):
			speed = 500 
		else:
			speed = 450 
		target_velocity = dash_direction * speed 
		can_dash = false
	
#Si on ne dash pas, alors le joueur se déplace. Si le dit comme ça, alors les deux mouvements ne se superposerons pas. Cet else est utilisé pour d'une part avoir le déplacement du joueur sur le sol mais aussi pour
#déterminer si on doit tourner l'image du joueur ou pas. Ce dernier point est utilsé par la suite pour déterminer dans quelle direction l'image regarde durant l'idle. 
	else :
		if parameter_axis > 0:
			$Sprites_folder/girl_animation_sprites.flip_h = true
		elif parameter_axis < 0 :
			$Sprites_folder/girl_animation_sprites.flip_h = false
		else : 
			target_velocity.x = 0
		target_velocity.x = parameter_axis * speed


# Cette fonction, comme son nom l'indique, permettra au joueur de sauter. La première étape est de tput d'abords réinitaliser tous les variables lorsque le joueur est sur le sol. 
func jump(): 
	if is_on_floor() :
		can_double_jump = true
		can_dash = true
		can_jump = true	

#Lors le joueur appuie sur la touche de saut et qu'il est apte à sauter (si on ne met pas cette variable, le joueur pourrait sauter à l'infini), alors on dit au jeu de faire sauter le joueur
	if Input.is_action_just_pressed("jump") and can_jump:
		target_velocity.y = -jump_impulse 
		is_jumping = true
		can_jump = false

#Si le joueur rappuie sur le boutond de saut après avoir sauter, il pourra alors faire un double jump. la variable Global permettra de dire à tous le monde que le joueur fait son double
#saut et cette dernière est utile pour placer les effets. 
	elif Input.is_action_just_pressed("jump") and can_double_jump:
		target_velocity.y = -jump_impulse
		can_double_jump = false
		Global.double_jump_input_pressed = true	

#Si le joueur ne saute pas, alors la gravité va l'attirer vers le sol. Le delay est en faite un timer qui va permettre au joueur d'avoir une marge pour sauter. Il y a un min qui est présent en raison
#de ma manière d'avoir exprimer l'attraction du joueur. En effet le += signifie qu'à chaque frame, on ajoute. C'est comme dans la réalité, ça donne une sensation d'accélération. Or comme dans la vraie
#vie, il y a une limite à notre accélération, d'où le minimum. 
	else:
		$delay.start()
		target_velocity.y += gravity
		target_velocity.y = min(target_velocity.y, 800)


#Cette fonction va permettre de faire le slide sur le mur. C'est un peu le même principe que pour la gravité sauf qu'on dit que ça doit être le cas seulement si le joueur est sur un mur
func wall_slide(parameter_delta):
	if is_on_wall() and Input.is_action_pressed("grab"):
		target_velocity.y += wall_gravity * parameter_delta
		target_velocity.y = min(target_velocity.y, 250)
		can_double_jump = true
		can_dash = true


#La fonction floor_slide va permettre de faire comme son nom l'indique, une glissade sur le sol. Le timer permet de dire quand arrêter l'animation de la glissade. 
func floor_slide(): 
	if Input.is_action_just_pressed("slide") and is_on_floor(): 
		is_floor_slide = true
		$floor_slide_stop.start()
		$normal_collision.disabled = true
		$floor_slide_collision.disabled = false
	

#fonction qui va gérer toutes les animations du joueur. Les deux prmières variables sont les collisions du joueur lors du slide et lorsqu'il est debout.
func animation(parameter_target_velocity):
	if is_on_wall_only() and Input.is_action_pressed("grab") :
		$AnimationPlayer.play("slide")
		$Sprites_folder/slide.flip_h = $Sprites_folder/girl_animation_sprites.flip_h	
		if $Sprites_folder/slide.flip_h :
			$Sprites_folder/slide.offset.x = 2.8
		else:
			$Sprites_folder/slide.offset.x = -0.455
	
	elif is_on_floor() and is_floor_slide: 
		$AnimationPlayer.play("floor_slide")
		$normal_collision.disabled = true
		$floor_slide_collision.disabled = false
	
	elif is_jumping and not is_on_floor():
		$AnimationPlayer.play("jumping")
	
	elif parameter_target_velocity.x == 0 and is_on_floor():  
		$Sprites_folder/idle.flip_h = not $Sprites_folder/girl_animation_sprites.flip_h
		$AnimationPlayer.play("idle")
	
	elif is_on_floor() and parameter_target_velocity.x < 0:
		$AnimationPlayer.play("run")
	
	elif is_on_floor() and parameter_target_velocity.x > 0:
		$AnimationPlayer.play("run")
	
	else: 
		$AnimationPlayer.play("falling")


# Cette fonction principale est celle qui va tourner tout au long du jeu et s'update à chaque frame. Ici, on prend deux varibales de mouvement: direction et axis
func _physics_process(delta):

#Direction permettra d'avoir les coordonées x et y du joystick. Mais il y a un soucis: si le joueur actionne un tout petit peu le joystick, 
#alors le joueur avancera lentement. Pour les claviers, il n'y a pas ce soucis. C'est pour cela qu'il y a le normalized.
#Il prend un cercle de rayon 1 et donne la position. 
	var direction = Input.get_vector("left","right","up","down").normalized()

#Mais il y a un autre soucis qui vient: si le joueur tiens diagonalement le joystick, alors la vitesse est réduit (pythagore et vecteur). Il fallait avoir un moyen
# d'avoir seulement les axes x; c'est à dire 1 ou 0 et non 0.541, ou un autre nombre. C'est pour cela qu'il y a la variable axis avec un round (car normalized fonctionne seulement en deux dimensions)
	var axis = round(Input.get_axis("left","right"))

#On appelle de toutes les fonction permettant au joueur de bouger
	movement_dash(direction, axis)
	jump()
	wall_slide(delta)
	floor_slide()
	animation(target_velocity)

#velocity est la variable interne de la vitesse du joueur et prendra la valeur de target velocity permettant ainsi de bouger et de sauter
	velocity = target_velocity
	move_and_slide()


#lorsque les timer atteignent zéro, ils appliques ce qu'on leur demande
func _on_dash_stop_timeout():
	dashing = false
	speed = 350

func _on_delay_timeout():
	can_jump = false

func _on_floor_slide_stop_timeout():
	is_floor_slide = false 
	$normal_collision.disabled = false
	$floor_slide_collision.disabled = true
