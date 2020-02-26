extends Control

func died():
	show()
	get_node("PlaythroughStats").SetLabels(GameData.player_kills, GameData.current_level)
