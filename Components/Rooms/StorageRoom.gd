extends 'RoomBase.gd'

func setup_params():
	SYMMETRY.none
	extents_distribution = Set.new([Vector2(7, 7)])
	environment_distribution = IndependentDistribution.new([
		{ "p": 1, "value": load("res://Environments/LevelStairs.tscn"), "position": Vector2(3, 3) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(1,1) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(1,2) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(1,3) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(1,4) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(1,5) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(2,1) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(2,2) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(2,3) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(2,4) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(2,5) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(3,1) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(3,2) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(3,4) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(3,5) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(4,1) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(4,2) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(4,3) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(4,4) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(4,5) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(5,1) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(5,2) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(5,3) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(5,4) },
		{ "p": 1, "value": Constants.Environments.Storage, "position": Vector2(5,5) }])
