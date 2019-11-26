extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(7, 7)])
	npc_distribution = Distribution.new(
	[
		{
			"p": 1, 
			"value": load("res://Characters/TrainingDummy.tscn"),
			"position": Vector2(4, 1)
		}
	])
	environment_distribution = Distribution.new([])
	item_distribution = Distribution.new([])