extends RichTextLabel

#"Le temps passe et la mort vient"- proverbe français (http://evene.lefigaro.fr/citation/temps-passe-mort-vient-32358.php)
var text_1 = '"When time flies, death comes."
- french quotation'

func _ready():
	BackroungMusic.stop()
	scroll_text(text_1)


#Le code ne vient pas de moi. Il vient d'un youtubeur du nom de ... 
func scroll_text(text_input) : 
	visible_characters = 0
	text = text_input
	for i in get_parsed_text() : 
		visible_characters += 1
		$"../Tick_sound".play()
		await get_tree().create_timer(0.05).timeout
	
	await get_tree().create_timer(3).timeout
	$".".visible = false
	$"../Tick_sound".play()
	

#Après cette animation, on place le timer, et on reinitialise le "must_close" (qui est la variable qui nous permettra de faire une animation seulement une fois et non deux fois)
	await get_tree().create_timer(0.2).timeout
	Global.level_time = 3.5
	Global.has_played_once = false
	get_tree().change_scene_to_file("res://Levels/Levels/level_1.tscn")


