extends TextureButton

func pressed():
	GameData.toggle_mute()
	if GameData.muted:
		get_node("Label").text = "Unmute"
	else:
		get_node("Label").text = "Mute"