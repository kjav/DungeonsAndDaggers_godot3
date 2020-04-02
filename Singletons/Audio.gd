extends Node

func _ready():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), GameData.muted)
	get_node("StreamPlayer").play()
