extends RichTextLabel

var text_1 = '"When time flies, death comes."
- french quotation'

#Le temps passe et la mort vient.

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	scroll_text(text_1)

func scroll_text(text_input) : 
	visible_characters = 0
	text = text_input
	for i in get_parsed_text() : 
		visible_characters += 1
		$"../Tick_sound".play()
		await get_tree().create_timer(0.05).timeout
	
	await get_tree().create_timer(3).timeout
	visible_characters = len(text_1)
	for j in get_parsed_text():
		visible_characters -= 1
		await get_tree().create_timer(0.01).timeout
	

	await get_tree().create_timer(1.5).timeout
	Global.level_time = 3
	Global.must_close = true
	get_tree().change_scene_to_file("res://Levels/Levels/level_1.tscn")


