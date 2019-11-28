extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(7, 7)])
	npc_distribution = IndependentDistribution.new(
	[
		{
			"p": 1, 
			"value": load("res://Characters/TrainingDummy.tscn"),
			"position": Vector2(5, 2)
		},
		{
			"p": 1, 
			"value": load("res://Characters/TrainingDummy.tscn"),
			"position": Vector2(5, 4)
		}
	])
	environment_distribution = IndependentDistribution.new(
	[
		{
			"p": 1,
			"value": load("res://Environments/LevelStairs.tscn"),
			"position": Vector2(3, 1)
		},
		{
			"p": 1,
			"value": load("res://Environments/Chest.tscn"),
			"position": Vector2(2, 4)
		}
	])
	item_distribution = Distribution.new([{
		"p": 1, 
		"value": Constants.WeaponClasses.UncommonSpear,
		"position": Vector2(1, 3)
	}])