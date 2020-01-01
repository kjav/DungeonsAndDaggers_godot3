extends 'RoomBase.gd'

func _init():
	doorClass = preload("res://Environments/BossDoor.tscn")
	isBossRoom = true
	oneEntrance = true

func setup_params():
	extents_distribution = Set.new([Vector2(9, 7)])
	
	npc_distribution = IndependentDistribution.new([
		{
			"p": 1, 
			"value": load("res://Characters/BossOgre.tscn"),
			"position": Vector2(1, 1),
		}
	])
