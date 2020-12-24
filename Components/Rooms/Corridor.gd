extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(3, 5)])

func apply_randomness():
	extents_distribution = Set.new([Vector2(3, randi()%3+4)])
