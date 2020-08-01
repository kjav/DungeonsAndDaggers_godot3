extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	
	environment_distribution = IndependentDistribution.new([
		{
		"p": 1, 
		"value": Constants.AllChestsDistribution.pick()[0].value,
		"position": Vector2(2, 1)
		},
		{
		"p": 1, 
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(2, 2)
		}
	])
