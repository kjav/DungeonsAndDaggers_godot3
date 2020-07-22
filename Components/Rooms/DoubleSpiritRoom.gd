extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 6)])
	
	environment_distribution = IndependentDistribution.new([
		{ "p": 0.2, "value": load("res://Environments/Trap.tscn") },
		{ "p": 0.2, "value": load("res://Environments/Trap.tscn") }
	])
	
	npc_distribution = IndependentDistribution.new([
		{ "p": 0.9, "value": Constants.Enemies.ZombieCreme },
		{ "p": 0.9, "value": Constants.Enemies.ZombieBrown }
	])

func apply_randomness():
	item_distribution = Distribution.new([
		{ "p": 0.10, "value": Constants.CommonPotionsDistribution.pick()[0].value },
		{ "p": 0.02, "value": Constants.UncommonPotionsDistribution.pick()[0].value }
	])
