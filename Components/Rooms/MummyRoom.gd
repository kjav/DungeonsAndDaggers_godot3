extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	
	npc_distribution = Distribution.new([{"p": 0.95, "value": load("res://Characters/Mummy.tscn")}])
