extends Node2D

func _ready():
	get_node("Monsters Amount").text = str(GameData.player_kills)
	get_node("Level Amount").text = str(GameData.current_level)
