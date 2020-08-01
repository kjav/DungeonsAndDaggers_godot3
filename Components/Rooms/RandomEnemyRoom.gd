extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(9, 9)])
	npc_distribution = Distribution.new([{"p": 1, "value": Constants.AllHarmfulEnemies.pick()[0].value, "position": Vector2(1,3)}])
	
	environment_distribution = Distribution.new([{
		"p": 1,
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(4, 4)
	}])  
