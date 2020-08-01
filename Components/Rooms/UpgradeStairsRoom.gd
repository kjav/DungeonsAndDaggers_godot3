extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	npc_distribution = Distribution.new([])
	environment_distribution = IndependentDistribution.new([
		{
			"p": 1,
			"value": load("res://Environments/UpgradeStand.tscn"),
			"position": Distribution.new([
				{ "p": 1, "value": Vector2(1, 1) }
			])
		},
		{
			"p": 1,
			"value": load("res://Environments/LevelStairs.tscn"),
			"position": Distribution.new([
				{ "p": 1, "value": Vector2(2, 2) }
			])
		}
	])
	item_distribution = Distribution.new([])
