extends "../../Hud/scripts/ItemPopupBaseScript.gd"

func _init().():
	longPressTime = 0
	popupPosition = "right"

func withinTileBounds(pos):
	var button = get_node("Higher Locked")

	var size = button.get_global_transform().get_scale() * button.get_size()
	var position = button.get_global_position()
	
	return pos.x >= position.x - size.y and pos.x <= position.x and pos.y >= position.y and pos.y < position.y + size.x && button.visible

func getTitle():
	return "Locked"

func getDescription():
	return "Beat the first boss floor in this difficulty to unlock the next!"

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
