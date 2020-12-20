extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	
	environment_distribution = IndependentDistribution.new([{
		"p": 0.5, 
		"value": load("res://Environments/Trap.tscn")
	},
	
		{ "p": 0.6, "value": Constants.Environments.Storage }
		])

func apply_randomness():
	item_distribution = IndependentDistribution.new([
	{
		"p": 0.5, "value": Distribution.new([
			{ "p": 0.45, "value": Constants.AllCommonPotionsSpellsDistribution.pick()[0].value },
			{ "p": 0.5, "value": Constants.AllUncommonPotionsSpellsDistribution.pick()[0].value },
			{ "p": 0.05, "value": Constants.AllRarePotionsSpellsDistribution.pick()[0].value }
		]).pick()[0].value 
	},
	{
		"p": 0.5, "value": Distribution.new([
			{ "p": 0.45, "value": Constants.AllCommonPotionsSpellsDistribution.pick()[0].value },
			{ "p": 0.5, "value": Constants.AllUncommonPotionsSpellsDistribution.pick()[0].value },
			{ "p": 0.05, "value": Constants.AllRarePotionsSpellsDistribution.pick()[0].value }
		]).pick()[0].value 
	},
	{
		"p": 0.5, "value": Distribution.new([
			{ "p": 0.45, "value": Constants.AllCommonPotionsSpellsDistribution.pick()[0].value },
			{ "p": 0.5, "value": Constants.AllUncommonPotionsSpellsDistribution.pick()[0].value },
			{ "p": 0.05, "value": Constants.AllRarePotionsSpellsDistribution.pick()[0].value }
		]).pick()[0].value 
	}
	])
