extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(4, 5)])
	
	npc_distribution = Distribution.new([{"p": 0.95, "value": Constants.Enemies.Reaper}])
	
	environment_distribution = IndependentDistribution.new([{
		"p": 0.1, 
		"value": load("res://Environments/Trap.tscn")},
		{ "p": 0.1, "value": Constants.Environments.Storage } ])

func apply_randomness():
	item_distribution = Distribution.new([
		{ "p": 0.03, "value": Constants.PotionClasses.InvisibilityPotion },
		{ "p": 0.02, "value": Constants.CommonPotionsDistribution.pick()[0].value },
		{ "p": 0.01, "value": Constants.UncommonPotionsDistribution.pick()[0].value }
	])
