extends TextureRect

func _ready():
	GameData.loadCurrentDifficulties()
	updateForDifficulty()

func leftButtonPressed():
	if GameData.currentDifficultyUndeadCrypt > 0:
		GameData.currentDifficultyUndeadCrypt -= 1
	
	updateForDifficulty()

func rightButtonPressed():
	if GameData.currentDifficultyUndeadCrypt < GameData.unlockedDifficultiesUndeadCrypt.size() - 1:
		GameData.currentDifficultyUndeadCrypt += 1
	
	updateForDifficulty()

func updateForDifficulty():
	get_node("Label").text = GameData.unlockedDifficultiesUndeadCrypt[GameData.currentDifficultyUndeadCrypt]
	get_node("Left").visible = GameData.currentDifficultyUndeadCrypt != 0
	get_node("Divider Left").visible = GameData.currentDifficultyUndeadCrypt != 0
	get_node("Higher Locked").visible = GameData.currentDifficultyUndeadCrypt == GameData.unlockedDifficultiesUndeadCrypt.size() - 1
	
	GameData.saveCurrentDifficulties()
