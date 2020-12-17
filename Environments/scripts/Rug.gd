extends "EnvironmentBase.gd"

func _ready():
	play(getAnimationName())
	walkable = Enums.WALKABLE.ALL

func getAnimationName():
	if randi()%2 == 0:
		return "new"
	else:
		return "old"
