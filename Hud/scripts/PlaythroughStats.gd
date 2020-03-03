extends Node2D

var record_player_kills = 0
var record_current_level = 0

func _ready():
	load_highscores()

func _draw():
	get_node("Monsters Amount").text = str(GameData.player_kills)
	var playerKillsRecord = max(record_player_kills, GameData.player_kills)
	get_node("Monsters Highscore Amount").text = str(playerKillsRecord)

	get_node("Level Amount").text = str(GameData.current_level)
	var levelRecord = max(record_current_level, GameData.current_level)
	get_node("Level Highscore Amount").text = str(levelRecord)

	save_highscores(playerKillsRecord, levelRecord)
	
func save_highscores(killsHighscore, levelHighscore):
	var highscores = File.new()
	
	highscores.open(highscores_save_name(), File.WRITE)
	
	highscores.store_line(to_json({
		"kills": killsHighscore,
		"level": levelHighscore
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