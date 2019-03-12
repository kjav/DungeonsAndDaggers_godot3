extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(4, 12)])
	npc_distribution = Distribution.new([])
	environment_distribution = Distribution.new([])
	item_distribution = Distribution.new([{"p": 0.8, "value": Constants.SpellClasses.FireSpell}])
