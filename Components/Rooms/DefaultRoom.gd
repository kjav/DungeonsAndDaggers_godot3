extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(7, 7)])
	npc_distribution = Distribution.new(
	[
		{
			"p": 1, 
			"value": load("res://Characters/TrainingDummy.tscn"),
			"position": Vector2(2, 2)
		}
	])
	environment_distribution = Distribution.new([{"p": 1.0, "value": load("res://Environments/Chest.tscn")}])
	item_distribution = Distribution.new([{"p": 1.0, "value": Constants.KeyClasses.SilverKey}])
