extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(4, 4)])
	
	npc_distribution = Distribution.new([{"p": 0.95, "value": Constants.Enemies.Raven}])
