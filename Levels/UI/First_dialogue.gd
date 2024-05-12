extends RichTextLabel

var text_1 = '"Le temps passe et la mort vient."
					- french quotation'


# Called when the node enters the scene tree for the first time.
func _ready():
	scroll_text(text_1)

func scroll_text(text_input) : 
	visible_characters = 0
	text = text_input
	for i in get_parsed_text() : 
		visible_characters += 1
		await get_tree().create_timer(0.07).timeout
	
	await get_tree().create_timer(2).timeout
	visible_characters = len(text_1)
	for j in get_parsed_text():
		visible_characters -= 1
		await get_tree().create_timer(0.01).timeout
	
	get_tree().change_scene_to_file("res://Levels/Levels/level_1.tscn")


