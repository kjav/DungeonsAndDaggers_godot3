extends "../../Hud/scripts/ItemPopupBaseScript.gd"

func _init().():
	longPressTime = 0
	popupPosition = "left"

func withinTileBounds(pos):
	var button = get_node("Higher Locked")

	var size = button.get_global_transform().get_scale() * button.get_size()
	var position = button.get_global_position()
	
	return pos.x >= position.x - size.y and pos.x <= position.x and pos.y >= position.y and pos.y < position.y + size.x && button.visible

func getTitle():
	if GameData.unlockedGameModesUndeadCrypt[GameData.currentGameModeUndeadCrypt] == "Fast Paced":
		return "Coming Soon!"
	
	return "Locked"

func getDescription():
	if GameData.unlockedGameModesUndeadCrypt[GameData.currentGameModeUndeadCrypt] == "Fast Paced":
		return "We are working hard to improve the game at the moment and more game modes will be coming soon!"
	
	return "Reach Level 4 in this mode to unlock the next one! The next mode is " + GameData.possibleGameModes[GameData.currentGameModeUndeadCrypt + 1]

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

func lockedNextClicked():
	pass
