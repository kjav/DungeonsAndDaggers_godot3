extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(9, 13)])
	symmetry = SYMMETRY.none
	environment_distribution = Distribution.new([{
		"p": 1,
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(4, 6)
	}])  

func apply_randomness():
	item_distribution = IndependentDistribution.new([
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	},
	{
		"p": 1, "value": Constants.AllItemsDistribution.pick()[0].value 
	}
	])
