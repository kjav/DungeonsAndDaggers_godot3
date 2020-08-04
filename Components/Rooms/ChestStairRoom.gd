extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	
	environment_distribution = IndependentDistribution.new([
		{
		"p": 1, 
		"value": Constants.Environments.CommonChest,
		"position": Vector2(1, 1)
		},
		{
		"p": 1, 
		"value": Constants.Environments.UncommonChest,
		"position": Vector2(2, 1)
		},
		{
		"p": 1, 
		"value": Constants.Environments.RareChest,
		"position": Vector2(3, 1)
		},
		{
		"p": 1, 
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(2, 2)
		}
	])
