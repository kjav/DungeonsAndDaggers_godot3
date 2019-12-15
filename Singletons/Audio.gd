extends Node

func _ready():
	if not GameData.muted:
		get_node("StreamPlayer").play()