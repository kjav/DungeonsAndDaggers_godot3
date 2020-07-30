extends "MapBase.gd"

var rooms = []
var valid_exterior_walls = []

var TutorialLevelTwoRoom = load("res://Components/Rooms/TutorialLevelTwoRoom.gd").new()
var TutorialStartRoom = load("res://Components/Rooms/TutorialStartRoom.gd").new()
var TutorialSecondRoom = load("res://Components/Rooms/TutorialSecondRoom.gd").new()

func add_room(name, room, wall):
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
		var door_index = 4
		door = door_index * wall_direction + wall[0]
		
		# Choose how much to move the new room by
		var room_index = 2
		
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
		var positionInRoom = Vector2(1, 1)
		
		if enemy.has("position"):
			if typeof(enemy.position) == TYPE_OBJECT:
				if enemy.position.is_type("Distribution"):
					var picked = enemy.position.pick()[0].value
					positionInRoom = Vector2(picked.x, picked.y)
			else:
				positionInRoom = Vector2(enemy.position.x, enemy.position.y)
		else:
			positionInRoom = Vector2( randi()%int(round(roomDistribution.extents.x-2))+1, randi()%int(round(roomDistribution.extents.y-2))+1)
			
		npcs.push_back({"position": position + positionInRoom, "value": enemy.value, "isPartOfBossRoom": room.isBossRoom})
		
	# Add the items to the map
	for item in roomDistribution.items:
		var positionInRoom = Vector2(1, 1)
		if item.has("position"):
			positionInRoom = item.position
		items.push_back({"position": position + positionInRoom, "value": item.value})
		
	for env in roomDistribution.environments:
		var positionInRoom = Vector2(2, 1)
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
	randomize()
	
	var main_room
	
	if (level == 1):
		main_room = TutorialStartRoom
		
		add_room("main", main_room, null)
		
		var wall_index = 1
		var wall = valid_exterior_walls[0]
		var room = TutorialSecondRoom
		var success = add_room(1, room, wall)
		
		if success:
			valid_exterior_walls.remove(wall_index)
		
		make_walls_consistent()
	else:
		main_room = TutorialLevelTwoRoom
		
		add_room("main", main_room, null)
		
		make_walls_consistent()
	
	for textNode in GameData.hud.get_node("TutorialTextPrompts").get_children():
		textNode.hide()
		textNode.queue_free()
