tool
extends "Chest.gd"

func _init():
	environment_name = "Common Chest"
	item_distribution = Constants.IndependentDistribution.new([{ "p": 1, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 1, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 1, "value": Constants.Distribution.new([{ "p": 0.7, "value": Constants.AllCommonItemsDistribution.pick()[0].value }, { "p": 0.3, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }]).pick()[0].value }, { "p": 0.1, "value": Constants.AllCommonItemsDistribution.pick()[0].value }])
