extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	npc_distribution = Distribution.new([])
	environment_distribution = Distribution.new([
		{
			"p": 1,
			"value": load("res://Environments/UpgradeStand.tscn"),
			"position": Distribution.new([
				{ "p": 1, "value": Vector2(1, 1) }
			])
		}
	])
	item_distribution = Distribution.new([])
