extends TextureButton

func _pressed():
	if GameData.chosen_map == "Tutorial" && GameData.current_level > 1:
		get_tree().paused = false
		GameData.start_screen = "world_select"
		get_tree().change_scene("res://Menus/UnifiedMenu.tscn")
		
		if not GameData.has_save_game("OgresDomain"):
			GameData.chosen_map = "OgresDomain"
			GameData.chosen_player = "BeserkerPlayer"
			get_tree().change_scene("Game.tscn")
	else:
		GameData.next_level()
		
		if GameData.chosen_map == "Tutorial" && GameData.current_level == 2:
			GameData.player.addTutorialTextIfTutorial("Move into\nobjects to\ninteract", Vector2(4.3, 10.1))
			GameData.player.addTutorialTextIfTutorial("Blue's best\nthen green\nworst is grey", Vector2(3.1, 7.2))
			GameData.player.addTutorialTextIfTutorial("Good luck\nand have fun", Vector2(4.7, 5.8))
	
	get_parent().hide()