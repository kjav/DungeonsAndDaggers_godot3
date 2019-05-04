extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(9, 9)])
	npc_distribution = Distribution.new([
		{
			"p": 1, 
			"value": load("res://Characters/BossOgre.tscn"),
			"position": Distribution.new([
				{ "p": 1, "value": Vector2(5, 5) }
			])
		}
	])
