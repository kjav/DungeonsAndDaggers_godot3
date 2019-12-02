extends TextureButton

func _pressed():
	GameData.next_level()
	
	if GameData.chosen_map == "Tutorial" && GameData.current_level == 2:
		GameData.player.addTutorialTextIfTutorial("Move into\nobjects to\ninteract", Vector2(4, 10))
		GameData.player.addTutorialTextIfTutorial("Blue's best\nthen green\nworst is grey", Vector2(3, 8))
		GameData.player.addTutorialTextIfTutorial("Good Luck!", Vector2(6, 6))
	
	get_parent().hide()