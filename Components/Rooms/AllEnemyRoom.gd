extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(9, 13)])
	symmetry = SYMMETRY.none
	npc_distribution = IndependentDistribution.new([
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(1, 2),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(2, 2),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(3, 2),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(4, 2),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(5, 2),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(6, 2),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(7, 2),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(1, 10),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(2, 10),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(3, 10),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(4, 10),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(5, 10),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(6, 10),
		},
		{
			"p": 1, 
			"value": Constants.AllHarmfulEnemies.pick()[0].value,
			"position": Vector2(7, 10),
		}
	])
