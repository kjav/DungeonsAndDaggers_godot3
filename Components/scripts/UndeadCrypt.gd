extends "MapBase.gd"

var rooms = []
var valid_exterior_walls = []
var n_rooms = 20

func level_rooms(level):
	if level == 1:
		return Distribution.new([
			{ "p": 0.25, "value": GameData.Rooms.RavenRoom },
			{ "p": 0.15, "value": GameData.Rooms.FillerRoom },
			{ "p": 0.15, "value": GameData.Rooms.Corridor },
			{ "p": 0.15, "value": GameData.Rooms.SpiritRoom },
			{ "p": 0.15, "value": GameData.Rooms.DoubleSpiritRoom },
			{ "p": 0.04, "value": GameData.Rooms.CommonLootRoom },
			{ "p": 0.04, "value": GameData.Rooms.CommonChestRoom },
			{ "p": 0.03, "value": GameData.Rooms.UncommonLootRoom },
			{ "p": 0.02, "value": GameData.Rooms.CommonWeaponRoom },
			{ "p": 0.02, "value": GameData.Rooms.UncommonWeaponRoom },
		])
	elif level == 2:
		return Distribution.new([
			{ "p": 0.2, "value": GameData.Rooms.RavenRoom },
			{ "p": 0.15, "value": GameData.Rooms.FillerRoom },
			{ "p": 0.15, "value": GameData.Rooms.Corridor },
			{ "p": 0.15, "value": GameData.Rooms.SpiritRoom },
			{ "p": 0.15, "value": GameData.Rooms.DoubleSpiritRoom },
			{ "p": 0.05, "value": GameData.Rooms.ReaperRoom },
			{ "p": 0.04, "value": GameData.Rooms.CommonLootRoom },
			{ "p": 0.04, "value": GameData.Rooms.CommonChestRoom },
			{ "p": 0.03, "value": GameData.Rooms.UncommonLootRoom },
			{ "p": 0.02, "value": GameData.Rooms.CommonWeaponRoom },
			{ "p": 0.02, "value": GameData.Rooms.UncommonWeaponRoom },
		])
	elif level == 3:
		return Distribution.new([
			{ "p": 0.25, "value": GameData.Rooms.ReaperRoom },
			{ "p": 0.2, "value": GameData.Rooms.RavenRoom },
			{ "p": 0.15, "value": GameData.Rooms.Corridor },
			{ "p": 0.1, "value": GameData.Rooms.FillerRoom },
			{ "p": 0.05, "value": GameData.Rooms.DoubleSpiritRoom },
			{ "p": 0.05, "value": GameData.Rooms.MageRoom },
			{ "p": 0.05, "value": GameData.Rooms.TrapRoom },
			{ "p": 0.04, "value": GameData.Rooms.UncommonWeaponRoom },
			{ "p": 0.03, "value": GameData.Rooms.UncommonLootRoom },
			{ "p": 0.03, "value": GameData.Rooms.UncommonChestRoom },
			{ "p": 0.03, "value": GameData.Rooms.CommonLootRoom },
			{ "p": 0.02, "value": GameData.Rooms.CommonChestRoom },
		])
	elif level == 4:
		return Distribution.new([
			{ "p": 0.2, "value": GameData.Rooms.RavenRoom },
			{ "p": 0.15, "value": GameData.Rooms.MageRoom },
			{ "p": 0.15, "value": GameData.Rooms.ReaperRoom },
			{ "p": 0.1, "value": GameData.Rooms.Corridor },
			{ "p": 0.1, "value": GameData.Rooms.FillerRoom },
			{ "p": 0.08, "value": GameData.Rooms.TrapRoom },
			{ "p": 0.07, "value": GameData.Rooms.UncommonWeaponRoom },
			{ "p": 0.05, "value": GameData.Rooms.MummyRoom },
			{ "p": 0.05, "value": GameData.Rooms.UncommonLootRoom },
			{ "p": 0.03, "value": GameData.Rooms.UncommonChestRoom },
			{ "p": 0.02, "value": GameData.Rooms.DoubleSpiritRoom },
		])
	elif level == 5:
		return Distribution.new([
			{ "p": 0.2, "value": GameData.Rooms.MummyRoom },
			{ "p": 0.15, "value": GameData.Rooms.ReaperRoom },
			{ "p": 0.15, "value": GameData.Rooms.MageRoom },
			{ "p": 0.12, "value": GameData.Rooms.RavenRoom },
			{ "p": 0.1, "value": GameData.Rooms.Corridor },
			{ "p": 0.08, "value": GameData.Rooms.TrapRoom },
			{ "p": 0.05, "value": GameData.Rooms.FillerRoom },
			{ "p": 0.055, "value": GameData.Rooms.UncommonWeaponRoom },
			{ "p": 0.035, "value": GameData.Rooms.UncommonLootRoom },
			{ "p": 0.02, "value": GameData.Rooms.UncommonChestRoom },
			{ "p": 0.015, "value": GameData.Rooms.RareWeaponRoom },
			{ "p": 0.015, "value": GameData.Rooms.RareLootRoom },
			{ "p": 0.01, "value": GameData.Rooms.RareChestRoom },
		])
	elif level == 6:
		return Distribution.new([
			{ "p": 0.2, "value": GameData.Rooms.MummyRoom },
			{ "p": 0.15, "value": GameData.Rooms.ReaperRoom },
			{ "p": 0.15, "value": GameData.Rooms.MageRoom },
			{ "p": 0.12, "value": GameData.Rooms.RavenRoom },
			{ "p": 0.1, "value": GameData.Rooms.Corridor },
			{ "p": 0.08, "value": GameData.Rooms.TrapRoom },
			{ "p": 0.05, "value": GameData.Rooms.FillerRoom },
			{ "p": 0.055, "value": GameData.Rooms.UncommonWeaponRoom },
			{ "p": 0.035, "value": GameData.Rooms.UncommonLootRoom },
			{ "p": 0.02, "value": GameData.Rooms.UncommonChestRoom },
			{ "p": 0.015, "value": GameData.Rooms.RareWeaponRoom },
			{ "p": 0.015, "value": GameData.Rooms.RareLootRoom },
			{ "p": 0.01, "value": GameData.Rooms.RareChestRoom },
		])
	else:
		return Distribution.new([
			{ "p": 0.2, "value": GameData.Rooms.MummyRoom },
			{ "p": 0.1, "value": GameData.Rooms.Corridor },
			{ "p": 0.1, "value": GameData.Rooms.ReaperRoom },
			{ "p": 0.2, "value": GameData.Rooms.MageRoom },
			{ "p": 0.15, "value": GameData.Rooms.RavenRoom },
			{ "p": 0.1, "value": GameData.Rooms.TrapRoom },
			{ "p": 0.05, "value": GameData.Rooms.UncommonWeaponRoom },
			{ "p": 0.03, "value": GameData.Rooms.UncommonLootRoom },
			{ "p": 0.017, "value": GameData.Rooms.UncommonChestRoom },
			{ "p": 0.02, "value": GameData.Rooms.RareWeaponRoom },
			{ "p": 0.02, "value": GameData.Rooms.RareLootRoom },
			{ "p": 0.013, "value": GameData.Rooms.RareChestRoom },
		])

func level_final_rooms(level):
	if GameData.isBossLevel(level):
		return []
	else:
		return [GameData.Rooms.UpgradeRoom, GameData.Rooms.StairsRoom]

func pick_bossroom(level):
	if GameData.isFirstBossLevel(level):
		return GameData.Rooms.BossRoomUndeadDragon
	
	return GameData.Rooms.DoubleBossRoomUndeadDragon

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
		var door_index = 1 + (randi() % (int((wall[1] - wall[0]).length()) - 1))
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
	var alreadyExistingWalls = []

	wall([corners[0], corners[1], corners[2], corners[3], corners[0]], alreadyExistingWalls)

	var atleastOneDoorSet = false
	var wallsWithPossibleDoors = possibleDoors(alreadyExistingWalls)
	
	if (wallsWithPossibleDoors != null && door != null):
		for wallWithDirection in wallsWithPossibleDoors:
			if wallWithDirection.size() > 0:
				var newDoor = wallWithDirection[randi() % wallWithDirection.size()]
				var facing

				add_door(newDoor[0])
				remove_wall([newDoor[0]])

				if newDoor[1] == Enums.WALLDIRECTION.HORIZONTAL:
					facing = "front"
				else:
					facing = "side"

				environmentObjects.push_back({"position": newDoor[0], "value": room.doorClass, "facing": facing})
				atleastOneDoorSet = true
	
	#this should never enter but i have seen weird behaviour and while i think it is fixed i added this to make sure
	if !atleastOneDoorSet && door != null:
		add_door(door)
		remove_wall([door])
		environmentObjects.push_back({"position": door, "value": room.doorClass, "facing": get_facing(wall_direction)})
		print("*Important! If you see this message there is a problem with door generation!*")
	
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
	if GameData.map_seed:
		# Use the loaded seed, adding the level multiplied by a large prime
		seed(GameData.map_seed + level * 524287)
	
	var tree = load("res://Components/scripts/SurroundingsTree.gd").new(10)
	tree.add_value([
		null, true, null,
		false, true, false,
		null, false, null, null
	], 42)
	
	var main_room
	if (GameData.isBossLevel(level)):
		main_room = pick_bossroom(level)
	else:
		main_room = GameData.Rooms.StartRoom
	add_room("main", main_room, null)
	
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
	
	make_walls_consistent()

func randomPositionInRoom(roomDistribution):
	return Vector2( randi()%int(round(roomDistribution.extents.x-2))+1, randi()%int(round(roomDistribution.extents.y-2))+1)
