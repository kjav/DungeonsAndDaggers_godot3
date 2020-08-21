extends TextureButton

func _pressed():
	GameData.delete_saved_game()
	GameData.stopSuggestingTutorial()
	GameData.StartNewGame()
	GameData.hud.resetForNewGame()
