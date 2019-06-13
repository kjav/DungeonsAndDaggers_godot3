extends TextureButton

func pressed():
	GameData.start_screen = "character_select"
	get_tree().change_scene("res://Menus/UnifiedMenu.tscn")
