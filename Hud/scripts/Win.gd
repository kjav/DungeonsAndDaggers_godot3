extends "OverlayMenu.gd"

func fadeIn():
	if GameData.currentDifficultyUndeadCrypt == GameData.unlockedDifficultiesUndeadCrypt.size() - 1:
		get_node("Difficulty Text").visible = true
		GameData.unlockNextDifficulty()
	
	get_node("confetti").emitting = true
	get_node("confetti").restart()
	get_node("confetti").show()
	
	.fadeIn()
