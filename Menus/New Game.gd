extends TextureButton

func _pressed():
	GameData.delete_saved_game()
	GameData.stopSuggestingTutorial()
	get_tree().change_scene("Game.tscn")
