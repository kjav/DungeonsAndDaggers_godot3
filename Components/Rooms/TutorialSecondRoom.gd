extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(6, 9)])
	npc_distribution = Distribution.new([])
	environment_distribution = Distribution.new([{
		"p": 1,
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(3, 6)
	}])
	item_distribution = Distribution.new([])