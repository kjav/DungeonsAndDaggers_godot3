extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])

	environment_distribution = Distribution.new([{
		"p": 1,
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(2, 2)
	}])

	
	item_distribution = IndependentDistribution.new([ 
		{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
		{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.CommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.UncommonWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 1, "value": Constants.Distribution.new([
				{ "p": 0.33, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.34, "value": Constants.AllRareItemsDistribution.pick()[0].value }
			]).pick()[0].value },
			{ "p": 0.1, "value": Constants.Distribution.new([
				{ "p": 0.43, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.33, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }, { "p": 0.24, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
			]).pick()[0].value },
	])