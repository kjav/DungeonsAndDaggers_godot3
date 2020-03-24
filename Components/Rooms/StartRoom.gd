extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	environment_distribution = Distribution.new([{
		"p": 1,
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(3, 2)
	}])

func apply_randomness():
	item_distribution = IndependentDistribution.new([ { "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value }
	])