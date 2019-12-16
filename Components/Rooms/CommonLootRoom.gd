extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	
	environment_distribution = Distribution.new([{
		"p": 0.5, 
		"value": load("res://Environments/Trap.tscn")
	}])

func apply_randomness():
	item_distribution = IndependentDistribution.new([
	{
		"p": 0.5, "value": Distribution.new([
			{ "p": 0.9, "value": Constants.AllCommonPotionsSpellsFoodsDistribution.pick()[0].value },
			{ "p": 0.1, "value": Constants.AllUncommonPotionsSpellsFoodsDistribution.pick()[0].value }
		]).pick()[0].value 
	},
	{
		"p": 0.5, "value": Distribution.new([
			{ "p": 0.9, "value": Constants.AllCommonPotionsSpellsFoodsDistribution.pick()[0].value },
			{ "p": 0.1, "value": Constants.AllUncommonPotionsSpellsFoodsDistribution.pick()[0].value }
		]).pick()[0].value 
	},
	{
		"p": 0.5, "value": Distribution.new([
			{ "p": 0.9, "value": Constants.AllCommonPotionsSpellsFoodsDistribution.pick()[0].value },
			{ "p": 0.1, "value": Constants.AllUncommonPotionsSpellsFoodsDistribution.pick()[0].value }
		]).pick()[0].value 
	}
	])