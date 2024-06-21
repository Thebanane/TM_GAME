extends Node

#Le fichier Global, comme son nom l'indique, est un fichier qui est tout le temps active. Par conséquent, on peut récupérer des varibales (et sûrement des fonctions aussi) depuis cette dernière. 
var player_pos: Vector2 
var is_double_jumping: bool
var double_jump_input_pressed: bool
var level_time : float
var must_die: bool
var music_intro_position: float = 0
var music_game_position: float = 0
var must_close: bool = true
var has_played_once: bool = false
var mode: String
var Pop_can_show: bool = false
var dash_pop : bool
