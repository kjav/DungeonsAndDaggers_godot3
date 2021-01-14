extends TextureButton

func _pressed():
	get_node("TutorialArrow").hide()
	if GameData.chosen_map == "Tutorial" && GameData.current_level > 1:
		get_tree().paused = false
		GameData.start_screen = "world_select"
		get_tree().change_scene("res://Menus/UnifiedMenu.tscn")
		
		if not GameData.has_save_game("UndeadCrypt"):
			GameData.chosen_map = "UndeadCrypt"
			GameData.chosen_player = "BeserkerPlayer"
			GameData.StartNewGame()
	else:
		GameData.next_level()
		
		if GameData.chosen_map == "Tutorial" && GameData.current_level == 2:
			GameData.addTutorialTextIfTutorial("Move into\nobjects to\ninteract.", Vector2(4.3, 10.1))
	
	get_parent().hide()
