extends Node2D

var record_player_kills = 0
var record_current_level = 0

func _draw():
	load_highscores()
	get_node("Monsters Amount").text = str(GameData.player_kills)
	get_node("Monsters Highscore Amount").text = str(record_player_kills)
	
	if (record_player_kills < GameData.player_kills):
		get_node("Monsters New Highscore").show()
		get_node("Monsters Highscore Text").hide()
		get_node("Monsters Highscore Amount").add_color_override("font_color", Color(0.5,0.5,0.5,1))

	get_node("Level Amount").text = str(GameData.current_level)
	get_node("Level Highscore Amount").text = str(record_current_level)
	
	if (record_current_level < GameData.current_level):
		get_node("Level New Highscore").show()
		get_node("Level Highscore Text").hide()
		get_node("Level Highscore Amount").add_color_override("font_color", Color(0.5,0.5,0.5,1))

	save_highscores()
	
func save_highscores():
	var highscores = File.new()
	
	highscores.open(highscores_save_name(), File.WRITE)
	
	highscores.store_line(to_json({
		"kills": max(record_player_kills, GameData.player_kills),
		"level": max(record_current_level, GameData.current_level)
	}))

	highscores.close()

func load_highscores():
	var highscores = File.new()
	if not highscores.file_exists(highscores_save_name()):
		return

	highscores.open(highscores_save_name(), File.READ)
	
	while not highscores.eof_reached():
		var state = parse_json(highscores.get_line())
		if state:
			record_player_kills = int(state.kills)
			record_current_level = int(state.level)
	
	highscores.close()

func highscores_save_name():
	return "user://" + GameData.chosen_map + "-highscores.save";