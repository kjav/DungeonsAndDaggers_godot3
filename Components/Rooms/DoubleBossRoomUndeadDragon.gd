extends 'RoomBase.gd'

func _init():
	doorClass = preload("res://Environments/BossDoor.tscn")
	isBossRoom = true
	oneEntrance = true
	symmetry = SYMMETRY.none

func setup_params():
	extents_distribution = Set.new([Vector2(7, 9)])

	npc_distribution = IndependentDistribution.new([
		{
			"p": 1, 
			"value": Constants.Enemies.UndeadDragon,
			"position": Vector2(1, 1),
		},
		{
			"p": 1, 
			"value": Constants.Enemies.UndeadDragon,
			"position": Vector2(5, 7),
		}
	])
