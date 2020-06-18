extends TextureRect

func _ready():
	GameData.loadCurrentDifficulties()
	updateForDifficulty()

func leftButtonPressed():
	if GameData.currentDifficultyOgreDomain > 0:
		GameData.currentDifficultyOgreDomain -= 1
	
	updateForDifficulty()

func rightButtonPressed():
	if GameData.currentDifficultyOgreDomain < GameData.unlockedDifficultiesOgreDomain.size() - 1:
		GameData.currentDifficultyOgreDomain += 1
	
	updateForDifficulty()

func updateForDifficulty():
	get_node("Label").text = GameData.unlockedDifficultiesOgreDomain[GameData.currentDifficultyOgreDomain]
	get_node("Left").visible = GameData.currentDifficultyOgreDomain != 0
	get_node("Divider Left").visible = GameData.currentDifficultyOgreDomain != 0
	get_node("Higher Locked").visible = GameData.currentDifficultyOgreDomain == GameData.unlockedDifficultiesOgreDomain.size() - 1
	
	GameData.saveCurrentDifficulties()