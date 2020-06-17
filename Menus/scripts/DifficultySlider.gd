extends TextureRect

var currentDifficulty = 0
var possibleDifficulties = ["easy", "normal"]

func _ready():
	get_node("Label").text = possibleDifficulties[currentDifficulty]