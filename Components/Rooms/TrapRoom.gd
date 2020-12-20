extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(7, 7)])
	
	environment_distribution = IndependentDistribution.new([
		{"p": 1, "value": load("res://Environments/Trap.tscn")},
		{"p": 1, "value": load("res://Environments/Trap.tscn")},
		{"p": 1, "value": load("res://Environments/Trap.tscn")},
		{"p": 1, "value": load("res://Environments/Trap.tscn")},
		{"p": 1, "value": load("res://Environments/Trap.tscn")},
		{"p": 1, "value": load("res://Environments/Trap.tscn")},
		{"p": 1, "value": load("res://Environments/Trap.tscn")},
		{ "p": 0.4, "value": Constants.Environments.Storage },
		{ "p": 0.4, "value": Constants.Environments.Storage },
		{ "p": 0.4, "value": Constants.Environments.Storage },
	])
