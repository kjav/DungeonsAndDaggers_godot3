extends TextureRect

func _ready():
	GameData.loadCurrentGameModes()
	updateForGameModes()

func leftButtonPressed():
	if GameData.currentGameModeUndeadCrypt > 0:
		GameData.currentGameModeUndeadCrypt -= 1
	
	updateForGameModes()

func rightButtonPressed():
	if GameData.currentGameModeUndeadCrypt < GameData.unlockedGameModesUndeadCrypt.size() - 1:
		GameData.currentGameModeUndeadCrypt += 1
	
	updateForGameModes()

func updateForGameModes():
	get_node("Label").text = GameData.unlockedGameModesUndeadCrypt[GameData.currentGameModeUndeadCrypt]
	get_node("Left").visible = GameData.currentGameModeUndeadCrypt != 0
	get_node("Divider Left").visible = GameData.currentGameModeUndeadCrypt != 0
	get_node("Higher Locked").visible = GameData.currentGameModeUndeadCrypt == GameData.unlockedGameModesUndeadCrypt.size() - 1
	
	GameData.saveCurrentGameModes()
