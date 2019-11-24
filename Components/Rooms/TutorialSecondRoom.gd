extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(4, 4)])
	npc_distribution = Distribution.new([])
	environment_distribution = Distribution.new([{
		"p": 1,
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(1, 1)
	}])
	item_distribution = Distribution.new([])