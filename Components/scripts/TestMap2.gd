extends "MapBase.gd"

var rooms = []
var exterior_walls = []

func add_room(name, room, wall):
	var door
	var shared_wall_index = -1
	var position
	var wall_direction
	
	if wall == null:
		position = Vector2(103, 104)
	else:
		# Get the direction of the wall, with the interior on the right hand side.
		wall_direction = (wall[1] - wall[0]).normalized().snapped(Vector2(1, 1))
		
		# Choose a door in the wall, excluding the corners of the wall.
		var door_index = 1 + (randi() % (int((wall[1] - wall[0]).length()) - 2))
		door = door_index * wall_direction + wall[0]
		
		# Choose how much to move the new room by
		var room_index = 1 + (randi() % (abs(int(room.extents.dot(wall_direction))) - 2))
		
		if wall_direction == Vector2(0, 1):
			position = door - Vector2(0, room_index)
			shared_wall_index = 3
		elif wall_direction == Vector2(-1, 0):
			position = door - Vector2(room_index, 0)
			shared_wall_index = 0
		elif wall_direction == Vector2(0, -1):
			position = door - Vector2(room.extents.x - 1, room_index)
			shared_wall_index = 1
		elif wall_direction == Vector2(1, 0):
			position = door - Vector2(room_index, room.extents.y - 1)
			shared_wall_index = 2
		else:
			print("WARNING: Wall direction not valid! Wall direction was set to: ")
			print(wall_direction)
			position = wall[0]
			shared_wall_index = 1
	
	# Check if the interior of the room fits on the map
	for x in range(position.x + 1, position.x + room.extents.x - 1):
		for y in range(position.y + 1, position.y + room.extents.y - 1):
			if tiles[y][x] != initial_tile:
				return false
	
	# Check that the walls do not cover up another door
	for x in range(position.x, room.extents.x + 1):
		for y in [0, room.extents.y - 1]:
			# Check this door is not our door!
			var this_coord = Vector2(x, y)
			if door != this_coord:
				if is_door(this_coord):
					return false
	for y in range(position.y + 1, position.y + room.extents.y - 1):
		for x in [0, room.extents.x - 1]:
			# Check this door is not our door!
			var this_coord = Vector2(x, y)
			if door != this_coord:
				if is_door(this_coord):
					return false
	
	var corners = [
		position,
		position + Vector2(room.extents.x - 1, 0),
		position + room.extents - Vector2(1, 1),
		position + Vector2(0, room.extents.y - 1)
	]
	
	# Add room to rooms array
	rooms.push_back({
		"name": name,
		"corners": corners
	})
	
	# Draw floor on map
	draw_floor(position, room.extents)
	
	# Draw walls on map
	wall([corners[0], corners[1], corners[2], corners[3], corners[0]])
	
	# Remove the wall and add a door
	if door != null:
		add_door(door)
		remove_wall([door])
		environmentObjects.push_back({"position": door, "value": doorClass, "facing": get_facing(wall_direction)})
	
	# Add exterior walls to walls list, so other rooms can be placed adjacent
	for i in range(0, 3):
		if i != shared_wall_index:
			exterior_walls.push_back([corners[i], corners[(i + 1) % 4]])
	
	# Add the NPCs to the map
	for enemy in room.npcs:
		npcs.push_back({"position": position + Vector2(1, 1), "value": enemy})
	# Add the items to the map
	
	for item in room.items:
		items.push_back({"position": position + Vector2(1, 1), "value": item})
		
	for env in room.environments:
		environmentObjects.push_back({"position": position + Vector2(2, 1), "value": env})
	
	# Room added successfully: return true
	return true

func get_facing(wall_direction):
	if (wall_direction != null):
		if (wall_direction.x == 0):
			return "side"
	return "front"

func _init().(200, 200, -1):
	var n_rooms = 40
	randomize()
	print("Starting: ")
	print("\n\n\n\n\n")
	print("# # ")
	print("# # ")
	print("# # ")
	var DefaultRoom = load("res://Components/Rooms/DefaultRoom.gd").new()
	var TallRoom = load("res://Components/Rooms/TallRoom.gd").new()
	var SuperTallRoom = load("res://Components/Rooms/SuperTallRoom.gd").new()
	var WideRoom = load("res://Components/Rooms/WideRoom.gd").new()
	var UpgradeRoom = load("res://Components/Rooms/UpgradeRoom.gd").new()
	var main_room = DefaultRoom.get()
	print(main_room.extents)
	print(main_room.npcs)
	print("# # ")
	print("# # ")
	print("# # ")
	print("\n\n\n\n\n")
	var tree = load("res://Components/scripts/SurroundingsTree.gd").new(10)
	tree.add_value([
		null, true, null,
		false, true, false,
		null, false, null, null
	], 42)
	
	var start = OS.get_ticks_msec()
	print("    Fill Time: ", OS.get_ticks_msec() - start)
	add_room("main", main_room, null)
	
	var mid_1 = OS.get_ticks_msec()

	var i = 0;
	var room_distribution = Distribution.new([
		{"p": 0.3, "value": DefaultRoom},
		{"p": 0.3, "value": UpgradeRoom},
		{"p": 0.3, "value": WideRoom},
		{"p": 0.05, "value": TallRoom},
		{"p": 0.05, "value": SuperTallRoom}
	])
	while rooms.size() < n_rooms:
		# Pick a wall
		var wall_index = randi() % exterior_walls.size()
		var wall = exterior_walls[wall_index]
		var room = room_distribution.pick()[0].get()
		
		var success = add_room(str(i), room, wall)
		if success:
			exterior_walls.remove(wall_index)
			i = i + 1
	
	var mid_2 = OS.get_ticks_msec()
	print("    Rooms time: ", OS.get_ticks_msec() - mid_1)
	
	make_walls_consistent()
	print("    Make walls consistent time: ", OS.get_ticks_msec() - mid_2)
	
	print("Total Time: ", OS.get_ticks_msec() - start)

