extends "EnvironmentBase.gd"

var rugs = [
	preload("res://assets/floor_tiles/old castle/Rug 1.png"),
	preload("res://assets/floor_tiles/old castle/Rug 2.png")
]
var rugs_n = [
	preload("res://assets/floor_tiles/old castle/Rug 1_n.png"),
	preload("res://assets/floor_tiles/old castle/Rug 2_n.png")
]

func _ready():
	var rugType = getType()
	get_node("Sprite").texture = rugs[rugType]
	get_node("Sprite").normal_map = rugs_n[rugType]
	walkable = Enums.WALKABLE.ALL

func getType():
	return randi()%2
