extends "MapBase.gd"

var rooms = []
var valid_exterior_walls = []

var DefaultRoom = load("res://Components/Rooms/DefaultRoom.gd").new()
var StairsRoom = load("res://Components/Rooms/StairsRoom.gd").new()
var TallRoom = load("res://Components/Rooms/TallRoom.gd").new()
var SuperTallRoom = load("res://Components/Rooms/SuperTallRoom.gd").new()
var WideRoom = load("res://Components/Rooms/WideRoom.gd").new()
var UpgradeRoom = load("res://Components/Rooms/UpgradeRoom.gd").new()
var FillerRoom = load("res://Components/Rooms/FillerRoom.gd").new()
var SpiritRoom = load("res://Components/Rooms/SpiritRoom.gd").new()
var DoubleSpiritRoom = load("res://Components/Rooms/DoubleSpiritRoom.gd").new()
var BatRoom = load("res://Components/Rooms/BatRoom.gd").new()
var CommonWeaponRoom = load("res://Components/Rooms/CommonWeaponRoom.gd").new()
var CommonChestRoom = load("res://Components/Rooms/CommonChestRoom.gd").new()
var CommonLootRoom = load("res://Components/Rooms/CommonLootRoom.gd").new()
var BossRoomOgre = load("res://Components/Rooms/BossRoomOgre.gd").new()

func level_rooms(level):
	if GameData.isBossLevel(level):
		return Distribution.new([
			{"p": 1, "value": BossRoomOgre}
		])
	else:
		return Distribution.new([
			{ "p": 0.5, "value": FillerRoom },
			{ "p": 0.15, "value": SpiritRoom },
			{ "p": 0.1, "value": BatRoom },
			{ "p": 0.1, "value": DoubleSpiritRoom },
			{ "p": 0.07, "value": CommonWeaponRoom },
			{ "p": 0.05, "value": CommonLootRoom },
			{ "p": 0.05, "value": CommonChestRoom },
		])

func level_final_rooms(level):
	if GameData.isBossLevel(level):
		return []
	else:
		return [UpgradeRoom, StairsRoom]

func pick_bossroom(level):
	# TODO: Pick harder bosses as game progresses
	return BossRoomOgre

func add_room(name, room, wall):
	room.apply_randomness()
	var door
	var shared_wall_index = -1
	var position
	var wall_direction
	var roomDistribution = room.getSpawnDistributions()
	
	if wall == null:
		# Place the first room in the centre of the map
		position = Vector2(106, 109) - Vector2(ceil(roomDistribution.extents.x / 2), ceil(roomDistribution.extents.y / 2))
	else:
		# Get the direction of the wall, with the interior on the right hand side.
		wall_direction = (wall[1] - wall[0]).normalized().snapped(Vector2(1, 1))
		
		# Choose a door in the wall, excluding the corners of the wall.
		var door_index = 1 + (randi() % (int((wall[1] - wall[0]).length()) - 2))
		door = door_index * wall_direction + wall[0]
		
		# Choose how much to move the new room by
		var room_index = 1 + (randi() % int(abs(int(roomDistribution.extents.dot(wall_direction))) - 2))
		
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
			position = door - Vector2(room_index, roomDistribution.extents.y - 1)
			shared_wall_index = 2
		else:
			print("WARNING: Wall direction not valid! Wall direction was set to: ")
			print(wall_direction)
			position = wall[0]
			shared_wall_index = 1
	
	# Check if the interior of the room fits on the map
	for x in range(position.x + 1, position.x + roomDistribution.extents.x - 1):
		for y in range(position.y + 1, position.y + roomDistribution.extents.y - 1):
			if tiles[y][x] != initial_tile:
				return false
	
	# Check that the walls do not cover up another door
	for x in range(position.x, roomDistribution.extents.x + 1):
		for y in [0, roomDistribution.extents.y - 1]:
			# Check this door is not our door!
			var this_coord = Vector2(x, y)
			if door != this_coord:
				if is_door(this_coord):
					return false
	for y in range(position.y + 1, position.y + roomDistribution.extents.y - 1):
		for x in [0, roomDistribution.extents.x - 1]:
			# Check this door is not our door!
			var this_coord = Vector2(x, y)
			if door != this_coord:
				if is_door(this_coord):
					return false
	
	var corners = [
		position,
		position + Vector2(roomDistribution.extents.x - 1, 0),
		position + roomDistribution.extents - Vector2(1, 1),
		position + Vector2(0, roomDistribution.extents.y - 1)
	]
	
	# Add room to rooms array
	rooms.push_back({
		"name": name,
		"corners": corners
	})
	
	# Draw floor on map
	draw_floor(position, roomDistribution.extents)
	
	# Draw walls on map
	wall([corners[0], corners[1], corners[2], corners[3], corners[0]])
	
	# Remove the wall and add a door
	if door != null:
		add_door(door)
		remove_wall([door])
		environmentObjects.push_back({"position": door, "value": room.doorClass, "facing": get_facing(wall_direction)})
	
	# Add exterior walls to walls list, so other rooms can be placed adjacent
	if !room.oneEntrance:
		for i in range(0, 3):
			if i != shared_wall_index:
				valid_exterior_walls.push_back([corners[i], corners[(i + 1) % 4]])
	
	# Add the NPCs to the map
	for enemy in roomDistribution.npcs:
		var positionInRoom = randomPositionInRoom(roomDistribution)
		
		if enemy.has("position"):
			if typeof(enemy.position) == TYPE_OBJECT:
				if enemy.position.is_type("Distribution"):
					var picked = enemy.position.pick()[0].value
					positionInRoom = Vector2(picked.x, picked.y)
			else:
				positionInRoom = Vector2(enemy.position.x, enemy.position.y)
		
		npcs.push_back({"position": position + positionInRoom, "value": enemy.value, "isPartOfBossRoom": room.isBossRoom})
		
	# Add the items to the map
	for item in roomDistribution.items:
		var positionInRoom = randomPositionInRoom(roomDistribution)
		
		if item.has("position"):
			if item.position.is_type("Distribution"):
				positionInRoom = item.position.pick()[0]
			else:
				positionInRoom = item.position
		
		items.push_back({"position": position + positionInRoom, "value": item.value})
		
	for env in roomDistribution.environments:
		var positionInRoom = randomPositionInRoom(roomDistribution)
		
		if env.has("position"):
			if typeof(env.position) == TYPE_OBJECT:
				if env.position.is_type("Distribution"):
					var picked = env.position.pick()[0].value
					positionInRoom = Vector2(picked.x, picked.y)
			else:
				positionInRoom = Vector2(env.position.x, env.position.y)
		
		environmentObjects.push_back({"position": position + positionInRoom, "value": env.value})
	
	# Room added successfully: return true
	return true

func get_facing(wall_direction):
	if (wall_direction != null):
		if (wall_direction.x == 0):
			return "side"
	return "front"

func _init(level).(200, 200, level, -1):
	var n_rooms = 10
	if GameData.map_seed:
		# Use the loaded seed, adding the level multiplied by a large prime
		seed(GameData.map_seed + level * 524287)
	
	var tree = load("res://Components/scripts/SurroundingsTree.gd").new(10)
	tree.add_value([
		null, true, null,
		false, true, false,
		null, false, null, null
	], 42)
	
	var start = OS.get_ticks_msec()
	
	var main_room
	if (GameData.isBossLevel(level)):
		main_room = pick_bossroom(level)
	else:
		main_room = DefaultRoom
	add_room("main", main_room, null)
	
	var mid_1 = OS.get_ticks_msec()

	
	var room_distribution = level_rooms(level)
	var final_rooms = level_final_rooms(level)
	var i = 0
  
	if not GameData.isBossLevel(level):
		while rooms.size() < n_rooms:
			# Pick a wall
			var wall_index = randi() % valid_exterior_walls.size()
			var wall = valid_exterior_walls[wall_index]
			var room = room_distribution.pick()[0].value
		
			var success = add_room(str(i), room, wall)
			if success:
				valid_exterior_walls.remove(wall_index)
				i += 1

		for room in final_rooms:
			var placed = false
			while not placed:
				# Pick a wall
				var wall_index = randi() % valid_exterior_walls.size()
				var wall = valid_exterior_walls[wall_index]
			
				var success = add_room(str(i), room, wall)
				if success:
					valid_exterior_walls.remove(wall_index)
					placed = true
					i += 1
	
	var mid_2 = OS.get_ticks_msec()
	
	make_walls_consistent()

func randomPositionInRoom(roomDistribution):
	return Vector2( randi()%int(round(roomDistribution.extents.x-2))+1, randi()%int(round(roomDistribution.extents.y-2))+1)
