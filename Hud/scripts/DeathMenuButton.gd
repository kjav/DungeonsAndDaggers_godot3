extends TextureButton

func pressed():
	get_tree().paused = false
	GameData.start_screen = "world_select"
	get_tree().change_scene("res://Menus/UnifiedMenu.tscn")
