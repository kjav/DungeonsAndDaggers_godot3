extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(7, 4)])
	npc_distribution = Distribution.new([{"p": 0.4, "value": Constants.Enemies.Raven}])
	environment_distribution = IndependentDistribution.new([
		{
			"p": 1,
			"value": load("res://Environments/Trap.tscn"),
			"position": Distribution.new([
				{ "p": 1, "value": Vector2(1, 1) }
			])
		},
		{ "p": 0.2, "value": Constants.Environments.Storage },
	])
	item_distribution = Distribution.new([{"p": 0.5, "value": Constants.PotionClasses.HealthPotion}])
