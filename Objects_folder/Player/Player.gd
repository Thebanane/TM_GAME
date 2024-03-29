extends CharacterBody2D
#variable vitesse
@export var speed = 480
#variables dash
var dashspeed
var dashing = false
var can_dash = true
var dash_direction: Vector2 = Vector2.ZERO
#variables qui détérminera le déplacement du joueur
@export var target_velocity = Vector2.ZERO
#variables saut et gravité
@export var gravity = 35
@export var jump_impulse = 200
var can_double_jump: bool = false
var can_jump : bool
#variables wall slide
@export var wall_gravity = 20
#variables animations
@export var is_jumping = false
@export var is_turning = false
#variable utile pour l'animation turn
var compare: bool  = true

	
#fonction qui va donner la vitesse du dash et deplacement du joueur
func dash(parameter_direction):
	if dashing:
		if dash_direction == Vector2(0,-1) or dash_direction == Vector2(0,1):
			dashspeed = 500
		elif dash_direction == Vector2(1,0) or dash_direction == Vector2(-1,0):
			dashspeed = 700
		else:
			dashspeed = 550
		target_velocity = dash_direction * dashspeed
		can_dash = false
	elif parameter_direction.x > 0:
		$Sprites_folder/girl_animation_sprites.flip_h = true
		target_velocity.x = parameter_direction.x * speed
	elif parameter_direction.x < 0:
		$Sprites_folder/girl_animation_sprites.flip_h = false
		target_velocity.x = parameter_direction.x * speed
	else:
		target_velocity.x = 0
#permet d'avoir la direction au moment de l'appuie comme ça on une direction fixe	
	if Input.is_action_just_pressed("dash") and can_dash and! parameter_direction == Vector2(0,0):
		dashing = true
		dash_direction = round(parameter_direction)
		$dash_stop.start()
#voir fonction must_turn_or_not
	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left") and is_on_floor():
		must_turn_or_not()
	return target_velocity

#fonction qui va permettre de faire l'animation turn seulement si on tourne le joueur. Si ce n'est pas le cas, l'animation ne se déclanchera pas
#c'est concrétement un XOR
func must_turn_or_not(): 
	if $Sprites_folder/girl_animation_sprites.flip_h != compare:
		is_turning = true
		compare = $Sprites_folder/girl_animation_sprites.flip_h
	else: 
		is_turning = false
		$AnimationPlayer.play("run")

# fonction saut/animation de saut et donneur de dash et double_saut	
func jump(): 
	if is_on_floor() :
		can_double_jump = true
		can_dash = true
		can_jump = true	
	if Input.is_action_just_pressed("jump") and can_jump:
		target_velocity.y = -jump_impulse 
		is_jumping = true
		is_turning = false
		can_jump = false
	elif Input.is_action_just_pressed("jump") and can_double_jump:
		target_velocity.y = -jump_impulse
		can_double_jump = false
		Global.double_jump_input_pressed = true	
	else:
		$Double_jump.start()
		target_velocity.y += gravity
		target_velocity.y = min(target_velocity.y, 900)
		is_turning = false



#fonction qui va permettre de faire le slide sur le mur
func slide(parameter):
	if is_on_wall() and not is_on_floor() :
		can_double_jump = false
		target_velocity.y += wall_gravity * parameter
		target_velocity.y = min(target_velocity.y, 300)
#		if Input.is_action_just_pressed("jump"):
#			target_velocity.y = -jump_impulse

#fonction qui va gérer toutes les animations du joueur
func animation(parameter_target_velocity):
	if is_on_floor() and is_turning:
		$AnimationPlayer.play("turn") 
		$Sprites_folder/Turn.flip_h = not $Sprites_folder/girl_animation_sprites.flip_h
	elif is_on_wall_only():
		$AnimationPlayer.play("slide")
		$Sprites_folder/slide.flip_h = $Sprites_folder/girl_animation_sprites.flip_h	
		if $Sprites_folder/slide.flip_h :
			$Sprites_folder/slide.offset.x = 2.8
		else:
			$Sprites_folder/slide.offset.x = -0.455
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

# fonction qui s'applique lorsque le jeu tourne et s'update chaque frame 
func _process(delta):
#direction sera un vecteur x et y avec comme valeur max = 1. Noramized donne l'angle mais prend comme valeur de x et y = 1 
	var direction = Input.get_vector("left","right","up","down").normalized()
#appelle de toutes les fonction permettant à' l'action du joueur
	dash(direction)
	jump()
	slide(delta)
	animation(target_velocity)
#velocity est la variable interne du joueur et prendra la valeur de target velocity permettant ainsi de bouger et de sauter
	velocity = target_velocity
	move_and_slide()

#lorsque le timer atteint zéro, alors le dash se désactivera. Utile pour pas faire des dash à l'infini
func _on_dash_stop_timeout():
	dashing = false

func _on_double_jump_timeout():
	can_jump = false
