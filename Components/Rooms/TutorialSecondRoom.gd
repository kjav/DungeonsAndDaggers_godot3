extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 10)])
	npc_distribution =  IndependentDistribution.new(
	[
		{
			"p": 1, 
			"value": load("res://Characters/WaterSpirit.tscn"),
			"position": Vector2(2, 2)
		},
		{
			"p": 1, 
			"value": load("res://Characters/FireSpirit.tscn"),
			"position": Vector2(2, 3)
		},
		{
			"p": 1, 
			"value": load("res://Characters/WaterSpirit.tscn"),
			"position": Vector2(2, 5)
		},
		{
			"p": 1, 
			"value": load("res://Characters/FireSpirit.tscn"),
			"position": Vector2(2, 6)
		}
	])
	environment_distribution = Distribution.new([{
		"p": 1,
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(3, 2)
	}])
	item_distribution = Distribution.new([])