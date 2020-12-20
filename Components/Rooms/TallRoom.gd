extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(4, 7)])
	npc_distribution = Distribution.new([{"p": 0.4, "value": Constants.Enemies.Mummy}])
	environment_distribution = Distribution.new([ { "p": 0.1, "value": Constants.Environments.Storage } ])
	item_distribution = Distribution.new([{"p": 0.8, "value": Constants.FoodClasses.CookedSteak}])
