extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(7, 7)])
	npc_distribution = Distribution.new([{"p": 1.0, "value": load("res://Characters/Reaper.tscn")}])
	environment_distribution = Distribution.new([])
	item_distribution = Distribution.new([{"p": 0.3, "value": Constants.SpellClasses.FireSpell}])

