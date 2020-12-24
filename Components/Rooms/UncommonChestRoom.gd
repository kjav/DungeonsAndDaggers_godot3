extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(5, 5)])
	
	environment_distribution = Distribution.new([{
		"p": 1, 
		"value": load("res://Environments/UncommonChest.tscn"),
		"position": Vector2(2, 2)
	}])
