extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(4, 6)])
	
	npc_distribution = Distribution.new([{"p": 1, "value": load("res://Characters/Necromancer.tscn")}])

func apply_randomness():	
	item_distribution = IndependentDistribution.new([
		{ "p": 0.15, "value": Constants.CommonSpellsDistribution.pick()[0].value },
		{ "p": 0.15, "value": Constants.CommonSpellsDistribution.pick()[0].value },
		{ "p": 0.1, "value": Constants.UncommonSpellsDistribution.pick()[0].value },
		{ "p": 0.1, "value": Constants.UncommonSpellsDistribution.pick()[0].value },
		{ "p": 0.05, "value": Constants.RareSpellsDistribution.pick()[0].value }
	])
