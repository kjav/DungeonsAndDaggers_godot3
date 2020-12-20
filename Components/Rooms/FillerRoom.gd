extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	npc_distribution = Distribution.new([])
	
	environment_distribution = Distribution.new([{
			"p": 0.1, 
			"value": load("res://Environments/Trap.tscn")
		},
		{ "p": 0.1, "value": Constants.Environments.Storage }
		])

func apply_randomness():
	var sizes = DistributionOfEquals.new([
		{ "value": Vector2(4, 4) },
		{ "value": Vector2(4, 5) },
		{ "value": Vector2(4, 6) },
		{ "value": Vector2(5, 5) },
		{ "value": Vector2(5, 6) }
	])
	
	item_distribution = IndependentDistribution.new([
		{ "p": 0.02, "value": Constants.AllCommonItemsDistribution.pick()[0].value },
		{ "p": 0.02, "value": Constants.AllCommonItemsDistribution.pick()[0].value }
	])
	
	extents_distribution = Set.new([sizes.pick()[0].value])
