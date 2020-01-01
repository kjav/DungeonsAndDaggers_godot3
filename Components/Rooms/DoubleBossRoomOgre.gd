extends 'RoomBase.gd'

func _init():
	doorClass = preload("res://Environments/BossDoor.tscn")
	isBossRoom = true
	oneEntrance = true

func setup_params():
	extents_distribution = Set.new([Vector2(9, 9)])

	environment_distribution = Distribution.new([{
		"p": 1,
		"value": load("res://Environments/LevelStairs.tscn"),
		"position": Vector2(2, 2)
	}])

	npc_distribution = IndependentDistribution.new([
		{
			"p": 1, 
			"value": load("res://Characters/BossOgre.tscn"),
			"position": Vector2(1, 1),
		},
		{
			"p": 1, 
			"value": load("res://Characters/BossOgre.tscn"),
			"position": Vector2(6, 6),
		}
	])
