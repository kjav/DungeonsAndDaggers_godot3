extends 'RoomBase.gd'

func setup_params():
	SYMMETRY.none
	extents_distribution = Set.new([Vector2(5, 5)])
	
	npc_distribution = IndependentDistribution.new([
		{ "p": 1, "value": load("res://Characters/TrainingDummy.tscn"), "position": Vector2(3,2) },
		{ "p": 1, "value": load("res://Characters/TrainingDummy.tscn"), "position": Vector2(1,2) }
	])

func apply_randomness():
	item_distribution = IndependentDistribution.new([ {
		"p": 0.7, "value": Distribution.new([
			{ "p": 0.55, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 0.4, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 0.05, "value": Constants.RareWeaponsDistribution.pick()[0].value }
		]).pick()[0].value },
		{ "p": 0.7, "value": Distribution.new([
			{ "p": 0.55, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 0.4, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 0.05, "value": Constants.RareWeaponsDistribution.pick()[0].value }
		]).pick()[0].value }
	])