extends TextureRect

var currentDifficulty = 0
var possibleDifficulties = ["easier", "normal"]

func _ready():
	updateForDifficulty()

func leftButtonPressed():
	if currentDifficulty > 0:
		currentDifficulty -= 1
	
	updateForDifficulty()

func rightButtonPressed():
	if currentDifficulty < possibleDifficulties.size() - 1:
		currentDifficulty += 1
	
	updateForDifficulty()

func updateForDifficulty():
	get_node("Label").text = possibleDifficulties[currentDifficulty]
	get_node("Left").visible = currentDifficulty != 0
	get_node("Divider Left").visible = currentDifficulty != 0
	get_node("Higher Locked").visible = currentDifficulty == possibleDifficulties.size() - 1