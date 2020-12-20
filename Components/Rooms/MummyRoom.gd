extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	
	npc_distribution = Distribution.new([{"p": 0.95, "value": Constants.Enemies.Mummy}])
	
	environment_distribution = Distribution.new([ { "p": 0.1, "value": Constants.Environments.Storage } ])
