extends 'RoomBase.gd'

func setup_params():
	SYMMETRY.none
	extents_distribution = Set.new([Vector2(5, 5)])
	
	npc_distribution = IndependentDistribution.new([
		{ "p": 1, "value": Constants.Enemies.TrainingDummy, "position": Vector2(3,2) },
		{ "p": 1, "value": Constants.Enemies.TrainingDummy, "position": Vector2(1,2) }
	])

func apply_randomness():
	item_distribution = IndependentDistribution.new([ {
		"p": 0.7, "value": Distribution.new([
			{ "p": 0.45, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 0.3, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 0.25, "value": Constants.RareWeaponsDistribution.pick()[0].value }
		]).pick()[0].value },
		{ "p": 0.7, "value": Distribution.new([
			{ "p": 0.45, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 0.3, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 0.25, "value": Constants.RareWeaponsDistribution.pick()[0].value }
		]).pick()[0].value }
	])