extends "OverlayMenu.gd"

func fadeIn():
	if GameData.currentDifficultyOgreDomain == GameData.unlockedDifficultiesOgreDomain.size() - 1:
		get_node("Difficulty Text").visible = true
		GameData.unlockNextDifficulty()
	
	.fadeIn()
