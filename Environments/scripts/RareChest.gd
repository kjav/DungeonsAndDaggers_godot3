tool
extends "Chest.gd"

func _init():
	environment_name = "Rare Chest"
	item_distribution = Constants.IndependentDistribution.new([
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