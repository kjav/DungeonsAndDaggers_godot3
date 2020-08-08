extends "TestLevel.gd"

var TrainingDummyRoom = load("res://Components/Rooms/TrainingDummyRoom.gd").new()

func _init(level).(level, "res://Components/Rooms/AllItemsRoom.gd", false):
	var wall_index = 2
	var wall = valid_exterior_walls[1]
	var room = TrainingDummyRoom
	var success = add_room(wall_index, room, wall)
	
	if success:
		valid_exterior_walls.remove(wall_index)
	
	make_walls_consistent()
