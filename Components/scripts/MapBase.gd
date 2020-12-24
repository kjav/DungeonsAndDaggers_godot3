var tiles = []
var npcs = []
var items = []
var environmentObjects = []
var initial_tile
var changed_tiles = {}

var door_tiles = {}

var tree = load("res://Components/scripts/SurroundingsTree.gd").new(10)
var Distribution = Constants.Distribution
var broken_floor_proportion = 0.1

func is_wall(tile):
	return tile in [GameData.Tiles["WallMiddle"], GameData.Tiles["WallMiddle_nobottom"], GameData.Tiles["Floor1_left_wall"], GameData.Tiles["Floor1_corner_topleft"], GameData.Tiles["Floor1_corner_topright"], GameData.Tiles["Floor1_corner_bottomleft"], GameData.Tiles["Floor1_over_corner_bottomleft"], GameData.Tiles["Floor1_corner_bottomright"], GameData.Tiles["Floor1_over_corner_bottomright"], GameData.Tiles["Floor1_over_corner_bottomrightleft"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall"], GameData.Tiles["Floor1_verticalwall_bottom_end"], GameData.Tiles["Floor1_corner_topright_with_rightwall"], GameData.Tiles["Floor1_corner_topleft_with_leftwall"], GameData.Tiles["Floor1_corner_topleft_nobottom"], GameData.Tiles["Floor1_corner_topright_nobottom"], GameData.Tiles["Floor1_corner_topleft_with_leftwall_nobottom"], GameData.Tiles["Floor1_corner_topright_with_rightwall_nobottom"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottom"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottomleft"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottomright"], GameData.Tiles["Wall 3_nobottom"], GameData.Tiles["Floor1_corner_bottomleft_nobottom"], GameData.Tiles["Floor1_corner_bottomright_nobottom"], GameData.Tiles["Floor1_corner_topleft_with_leftwall_nobottom"], GameData.Tiles["Floor1_corner_topright_with_rightwall_nobottom"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottom"], GameData.Tiles["Wall 3_nobottom"], GameData.Tiles["Floor1_corner_bottomleft_nobottom"], GameData.Tiles["Floor1_corner_bottomright_nobottom"]]
	
func _init(width, height, level, initial_tile=57):
	self.initial_tile = initial_tile
	
	tree.add_value([
		null, null, null,
		null, false, null,
		true, true, null, null
	], GameData.Tiles["Floor1_over_wall"])
	tree.add_value([
		null, null, null,
		null, false, null,
		null, true, true, null
	], GameData.Tiles["Floor1_over_wall"])
	
	tree.add_value([
		null, null, null,
		true, true, true,
		null, false, null, null
	], GameData.Tiles["WallMiddle"])
	tree.add_value([
		null, false, null,
		false, true, true,
		null, false, null, null
	], GameData.Tiles["WallMiddle"])
	tree.add_value([
		null, false, null,
		true, true, false,
		null, false, null, null
	], GameData.Tiles["WallMiddle"])
	tree.add_value([
		null, true, null,
		true, true, true,
		null, false, null, null
	], GameData.Tiles["WallMiddle"])
	tree.add_value([
		true, true, true,
		true, true, true,
		true, true, true, null
	], GameData.Tiles["WallMiddle_nobottom"])
	tree.add_value([
		null, null, null,
		null, true, null,
		null, true, null, null
	], GameData.Tiles["WallMiddle_nobottom"])
	tree.add_value([
		null, null, null,
		null, true, null,
		false, true, true, true
	], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottomright"])
	tree.add_value([
		null, null, null,
		null, true, null,
		true, true, false, true
	], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottomleft"])
	tree.add_value([
		null, null, null,
		null, true, null,
		true, true, true, true
	], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottom"])
	tree.add_value([
		null, null, null,
		null, true, null,
		false, true, false, true
	], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall"])
	
	# Vertical wall
	tree.add_value([
		null, null, null,
		false, true, false,
		false, true, false, null
	], GameData.Tiles["Floor1_left_wall"])
	tree.add_value([
		null, true, null,
		false, true, false,
		null, null, null, null
	], GameData.Tiles["Floor1_verticalwall_bottom_end"])
	
	# Horizontal wall endings with wall above
	tree.add_value([
		null, true, null,
		false, true, true,
		null, false, null, null
	], GameData.Tiles["Floor1_corner_bottomleft"])
	
	tree.add_value([
		null, true, null,
		true, true, false,
		null, false, null, null
	], GameData.Tiles["Floor1_corner_bottomright"])

	# Horizontal wall endings with wall below
	tree.add_value([
		null, false, null,
		false, true, true,
		null, true, false, null
	], GameData.Tiles["Floor1_corner_topleft"])
	tree.add_value([
		null, false, null,
		false, true, true,
		null, true, true, null
	], GameData.Tiles["Floor1_corner_topleft_nobottom"])
	tree.add_value([
		null, false, null,
		false, true, true,
		true, true, true, null
	], GameData.Tiles["Floor1_corner_topleft_with_leftwall_nobottom"])
	tree.add_value([
		null, false, null,
		false, true, true,
		true, true, false, null
	], GameData.Tiles["Floor1_corner_topleft_with_leftwall"])
	tree.add_value([
		null, false, null,
		true, true, false,
		true, true, null, null
	], GameData.Tiles["Floor1_corner_topright_nobottom"])
	tree.add_value([
		null, false, null,
		true, true, false,
		false, true, null, null
	], GameData.Tiles["Floor1_corner_topright"])
	tree.add_value([
		null, false, null,
		true, true, false,
		false, true, true, null
	], GameData.Tiles["Floor1_corner_topright_with_rightwall"])
	tree.add_value([
		null, false, null,
		true, true, false,
		true, true, true, null
	], GameData.Tiles["Floor1_corner_topright_with_rightwall_nobottom"])
	
	# Above horizontal wall
	tree.add_value([
		null, null, null,
		null, false, null,
		true, true, false,
		true
	], GameData.Tiles["Floor1_over_corner_topright"])
	tree.add_value([
		null, null, null,
		null, false, null,
		false, true, true,
		true
	], GameData.Tiles["Floor1_over_corner_topleft"])
	
	# Above vertical wall
	tree.add_value([
		null, null, null,
		null, false, null,
		false, true, false, null
	], GameData.Tiles["Floor1_over_verticalwall"])
	
	# Horizontal 1 way meets vertical 2 ways
	tree.add_value([
		null, true, null,
		false, true, true,
		null, true, false, null
	], GameData.Tiles["Floor1_corner_topleft"])
	tree.add_value([
		null, true, null,
		false, true, true,
		null, true, true, null
	], GameData.Tiles["Floor1_corner_topleft_nobottom"])
	tree.add_value([
		null, true, null,
		false, true, true,
		true, true, false, null
	], GameData.Tiles["Floor1_corner_topleft_with_leftwall"])
	tree.add_value([
		null, true, null,
		false, true, true,
		true, true, true, null
	], GameData.Tiles["Floor1_corner_topleft_with_leftwall_nobottom"])
	tree.add_value([
		null, true, null,
		true, true, false,
		true, true, null, null
	], GameData.Tiles["Floor1_corner_topright_nobottom"])
	tree.add_value([
		null, true, null,
		true, true, false,
		false, true, null, null
	], GameData.Tiles["Floor1_corner_topright"])
	tree.add_value([
		null, true, null,
		true, true, false,
		false, true, true, null
	], GameData.Tiles["Floor1_corner_topright_with_rightwall"])
	tree.add_value([
		null, true, null,
		true, true, false,
		true, true, true, null
	], GameData.Tiles["Floor1_corner_topright_with_rightwall_nobottom"])
	
	# L shapes
	tree.add_value([
		null, null, null,
		false, true, false,
		false, true, true, null
	], GameData.Tiles["Floor1_over_corner_bottomleft"])
	tree.add_value([
		null, null, null,
		false, true, false,
		true, true, false, null
	], GameData.Tiles["Floor1_over_corner_bottomright"])
	tree.add_value([
		null, null, null,
		false, true, false,
		true, true, true, null
	], GameData.Tiles["Floor1_over_corner_bottomrightleft"])
	
	# Horizontal walls
	tree.add_value([
		null, true, null,
		true, true, false,
		false, true, false, null
	], GameData.Tiles["Floor1_corner_topright"])
	tree.add_value([
		null, true, null,
		false, true, true,
		false, true, false, null
	], GameData.Tiles["Floor1_corner_topleft"])
	tree.add_value([
		null, null, null,
		true, true, true,
		false, true, false, null
	], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall"])
	
	for j in range(0, height):
		tiles.push_back([])
		for i in range(0, width):
			tiles[j].push_back(initial_tile)

# Fill the map with 1 tile type
func fill(tile):
	for j in range(0, tiles.size()):
		for i in range(0, tiles[j].size()):
			tiles[j][i] = tile

# Does the 9-tile surrounding area match the template?
func match(tiles, template):
	for i in range(0, template.size()):
		if template[i] != null:
			if tiles[i] != template[i]:
				return false
	return true

# Does the 9-tile surrounding area match any of the templates?
func match_any(tiles, templates):
	for template in templates:
		if match(tiles, template):
			return true
	return false

var up = Vector2(0, -1)
var down = Vector2(0, 1)
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var upleft = Vector2(-1, -1)
var upright = Vector2(1, -1)
var downleft = Vector2(-1, 1)
var downright = Vector2(1, 1)
var zero = Vector2(0, 0)
var downdown = Vector2(0, 2)
var upup = Vector2(0, -2)

# Create a wall between the given points
func wall(path, alreadyExistingWalls = []):
	var path_size = path.size()
	
	if path_size == 0:
		return
	
	if path_size == 1:
		var point = path[0]
		
		if tiles[point[1]][point[0]] == GameData.Tiles["WallMiddle"]:
			alreadyExistingWalls.append(Vector2(point[0], point[1]))
		
		tiles[point[1]][point[0]] = GameData.Tiles["WallMiddle"]
	else:
		for index in range(0, path.size() - 1):
			var point_a = path[index]
			var point_b = path[index + 1]
			var diff = point_b - point_a
			var move = Vector2(0, 0)

			if diff[0] == 0 and diff[1] != 0:
				# Moving vertically
				move.y = diff[1] / abs(diff[1])
			elif diff[0] != 0 and diff[1] == 0:
				# Moving horizontally
				move.x = diff[0] / abs(diff[0])
			else:
				print("Error: wall path contains a diagonal line.")
				return
			
			while point_a != point_b:
				if tiles[point_a.y][point_a.x] == GameData.Tiles["WallMiddle"]:
					alreadyExistingWalls.append(Vector2(point_a.x, point_a.y))
				
				tiles[point_a.y][point_a.x] = GameData.Tiles["WallMiddle"]
				changed_tiles[point_a] = true
				changed_tiles[point_a + right] = true
				changed_tiles[point_a + left] = true
				changed_tiles[point_a + down] = true
				changed_tiles[point_a + up] = true
				changed_tiles[point_a + upup] = true
				changed_tiles[point_a + downdown] = true
				point_a += move
		
		var point = path[-1]
			
		tiles[point.y][point.x] = GameData.Tiles["WallMiddle"]
		changed_tiles[point] = true
		changed_tiles[point + right] = true
		changed_tiles[point + left] = true
		changed_tiles[point + down] = true
		changed_tiles[point + up] = true
		changed_tiles[point + upup] = true
		changed_tiles[point + downdown] = true

func possibleDoors(path):
	var possibleDoorsInWalls = []
	var possibleDoors = []
	
	if path.size() > 0:
		var previousMovingHorizontal = null
		var possibleDoorWall = wallIfNotCorner(path[0])
		
		if possibleDoorWall != null:
			possibleDoors.append(possibleDoorWall)
		
		if path.size() > 1:
			for index in range(1, path.size()):
				var point_a = path[index]
				var point_b = path[index - 1]
				var diff = point_b - point_a
				var nextMoveHorizontal
				
				if diff[0] == 0 and diff[1] != 0:
					nextMoveHorizontal = false
				elif diff[0] != 0 and diff[1] == 0:
					nextMoveHorizontal = true
				else:
					possibleDoorsInWalls.append(possibleDoors)
					possibleDoors = []
				
				if previousMovingHorizontal == null && hasWallMoveChangedDirection(previousMovingHorizontal, nextMoveHorizontal) && possibleDoors.size() > 0:
					possibleDoorsInWalls.append(possibleDoors)
					possibleDoors = []
				
				previousMovingHorizontal = nextMoveHorizontal
				
				possibleDoorWall = wallIfNotCorner(point_a)
				
				if possibleDoorWall != null:
					possibleDoors.append(possibleDoorWall)
	
	possibleDoorsInWalls.append(possibleDoors)
	
	return possibleDoorsInWalls;

func wallIfNotCorner(point):
	var isHorizontal = is_horizontal_wall(point)
	var isVertical = is_vertical_wall(point)
	var wallDirection = Enums.WALLDIRECTION.NONE

	if isHorizontal && isVertical:
		wallDirection = Enums.WALLDIRECTION.CORNER
	elif isHorizontal:
		wallDirection = Enums.WALLDIRECTION.HORIZONTAL
	elif isVertical:
		wallDirection = Enums.WALLDIRECTION.VERTICAL
	
	if (wallDirection == Enums.WALLDIRECTION.HORIZONTAL || wallDirection == Enums.WALLDIRECTION.VERTICAL):
		return [Vector2(point.x, point.y), wallDirection]

func hasWallMoveChangedDirection(lastMoveHorizontal, nextMoveHorizontal):
	return lastMoveHorizontal != nextMoveHorizontal

func is_horizontal_wall(point):
	return is_door_or_wall(point + Vector2(1, 0)) || is_door_or_wall(point + Vector2(-1, 0))
	
func is_vertical_wall(point):
	return is_door_or_wall(point + Vector2(0, 1)) || is_door_or_wall(point + Vector2(0, -1))

func is_door_or_wall(point):
	return is_wall(tiles[point.y][point.x]) || is_door(point)

func choose_floor():
	if randf() < broken_floor_proportion:
		return GameData.Tiles["Floor3"]
	else:
		return GameData.Tiles["Floor1"]

func remove_wall(path):
	for index in range(0, path.size()):
		var point = path[index]
		tiles[point.y][point.x] = choose_floor()
		changed_tiles[point] = true

func draw_floor(position, extents):
	for x in range(position.x + 1, position.x + extents.x - 1):
		for y in range(position.y + 1, position.y + extents.y - 1):
			tiles[y][x] = choose_floor()

func make_walls_consistent():
	print("Making walls consistent: ")
	for point in changed_tiles:
		# If point in map
		if true:
			# Get the 10 tiles affecting the display of this tile
			var surroundings = [
				point + upleft, point + up, point + upright,
				point + left, point + zero, point + right,
				point + downleft, point + down, point + downright,
				point + downdown
			]
			
			var centre_is_wall = is_wall(tiles[surroundings[4].y][surroundings[4].x])
			
			for i in range(0, surroundings.size()):
				var x = surroundings[i].x
				var y = surroundings[i].y
				# Doors should count as walls to the tiles to their left and right.
				# Therefore we exclude the centre column of surroundings above in the
				# is_door check.
				surroundings[i] = is_wall(tiles[y][x]) or (i % 3 != 1 and is_door(Vector2(x, y))) or (i != 4 and is_door(Vector2(x, y)) and centre_is_wall)

			# Ignore cases where we are outside the map, unless there is a wall below us
			# if (tiles[point.y][point.x] == GameData.Tiles["Floor2_under_wall"]) and (not surroundings[7]):
			#	continue
			
			var value = tree.get_value(surroundings)
			if value == -1:
				value = choose_floor()
			tiles[point.y][point.x] = value
	changed_tiles = {}

func add_door(v):
	door_tiles[v] = true

func is_door(v):
	return door_tiles.has(v)
