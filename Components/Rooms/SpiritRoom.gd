extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(4, 5)])
	
	environment_distribution = Distribution.new([{
		"p": 0.2, 
		"value": load("res://Environments/Trap.tscn")
	}])

func apply_randomness():
	npc_distribution = Distribution.new([{ "p": 0.9, "value": DistributionOfEquals.new([
			{ "value": load("res://Characters/WaterSpirit.tscn") },
			{ "value": load("res://Characters/FireSpirit.tscn") }
		]).pick()[0].value}
	])
	
	item_distribution = Distribution.new([
		{ "p": 0.05, "value": Constants.CommonPotionsDistribution.pick()[0].value },
		{ "p": 0.01, "value": Constants.UncommonPotionsDistribution.pick()[0].value }
	])