extends Node2D

var Distribution = Constants.Distribution
const NON_PLAYABLE_TILES_NUMBER = 4

export(int) var bottom_z_index = 0
export(int) var top_z_index = 2
export(int, "TestChests", "TestUpgrades", "TestManyItems", "TestManyEnemy", "TestOneEnemy", "UndeadCrypt", "Tutorial") var map_type = 0 setget set_map_type, get_map_type

var Maps = {
	"TestChests": preload("res://Components/scripts/TestChests.gd"),
	"TestUpgrades": preload("res://Components/scripts/TestUpgrades.gd"),
	"TestManyItems": preload("res://Components/scripts/TestManyItems.gd"),
	"TestManyEnemy": preload("res://Components/scripts/TestManyEnemy.gd"),
	"TestOneEnemy": preload("res://Components/scripts/TestOneEnemy.gd"),
	"UndeadCrypt": preload("res://Components/scripts/UndeadCrypt.gd"),
	"Tutorial": preload("res://Components/scripts/TutorialMap.gd")
}

var not_walkable = [-1, GameData.Tiles["WallMiddle"], GameData.Tiles["WallMiddle_nobottom"], GameData.Tiles["Floor1_left_wall"], GameData.Tiles["Floor2_left_wall"], GameData.Tiles["Floor3_left_wall"], GameData.Tiles["Floor4_left_wall"], GameData.Tiles["Floor5_left_wall"], GameData.Tiles["Floor6_left_wall"], GameData.Tiles["Floor1_corner_topleft"], GameData.Tiles["Floor1_corner_topright"], GameData.Tiles["Floor1_corner_bottomleft"], GameData.Tiles["Floor1_over_corner_bottomleft"], GameData.Tiles["Floor1_corner_bottomright"], GameData.Tiles["Floor1_over_corner_bottomright"], GameData.Tiles["Floor1_over_corner_bottomrightleft"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall"], GameData.Tiles["Floor1_verticalwall_bottom_end"], GameData.Tiles["Floor1_corner_topright_with_rightwall"], GameData.Tiles["Floor1_corner_topleft_with_leftwall"],  GameData.Tiles["Floor1_corner_topleft_nobottom"], GameData.Tiles["Floor1_corner_topright_nobottom"], GameData.Tiles["Floor1_corner_topleft_with_leftwall_nobottom"], GameData.Tiles["Floor1_corner_topright_with_rightwall_nobottom"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottom"], GameData.Tiles["Wall 3_nobottom"], GameData.Tiles["Floor1_corner_bottomleft_nobottom"], GameData.Tiles["Floor1_corner_bottomright_nobottom"], GameData.Tiles["Floor1_corner_topleft_with_leftwall_nobottom"], GameData.Tiles["Floor1_corner_topright_with_rightwall_nobottom"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottom"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottomleft"], GameData.Tiles["Floor1_verticalwall_plus_horizontal_wall_nobottomright"], GameData.Tiles["Wall 3_nobottom"], GameData.Tiles["Floor1_corner_bottomleft_nobottom"], GameData.Tiles["Floor1_corner_bottomright_nobottom"]]
# This array is a boolean array, with elements at positions in the above array
# set to true, and all other elements false.
var flat_not_walkable = []

var Pathfinder
var points = {}
var ids = {}
var map = null

var top_layer_tiles = [GameData.Tiles["Floor1_over_wall"], GameData.Tiles["Floor2_over_wall"], GameData.Tiles["Floor3_over_wall"], GameData.Tiles["Floor4_over_wall"], GameData.Tiles["Floor5_over_wall"], GameData.Tiles["Floor6_over_wall"], GameData.Tiles["Floor3_door_tile"], GameData.Tiles["Floor1_over_corner_topleft"], GameData.Tiles["Floor1_over_corner_topright"], GameData.Tiles["Floor1_over_corner_bottomleft"], GameData.Tiles["Floor1_over_corner_bottomright"], GameData.Tiles["Floor1_over_corner_bottomrightleft"], GameData.Tiles["Floor1_over_verticalwall"], GameData.Tiles["Floor1_corner_topright_with_rightwall"], GameData.Tiles["Floor1_corner_topleft_with_leftwall"], 47]

var BottomTileMap
var TopTileMap

func tile_to_top_tile(n):
	if n in [GameData.Tiles["Floor1_over_wall"], GameData.Tiles["Floor2_over_wall"], GameData.Tiles["Floor3_over_wall"], GameData.Tiles["Floor4_over_wall"], GameData.Tiles["Floor5_over_wall"], GameData.Tiles["Floor6_over_wall"], GameData.Tiles["Floor3_door_tile"], GameData.Tiles["Floor1_over_corner_bottomrightleft"]]:
		return GameData.Tiles["Floor7_over_wall"]
	if n in [GameData.Tiles["Floor1_over_corner_topleft"],GameData.Tiles["Floor1_over_corner_bottomleft"],GameData.Tiles["Floor1_corner_topright_with_rightwall"]]:
		return GameData.Tiles["Floor7_over_corner_topleft"]
	if n in [GameData.Tiles["Floor1_over_corner_topright"], GameData.Tiles["Floor1_over_corner_bottomright"], GameData.Tiles["Floor1_corner_topleft_with_leftwall"]]:
		return GameData.Tiles["Floor7_over_corner_topright"]
	if n in [GameData.Tiles["Floor1_over_verticalwall"]]:
		return GameData.Tiles["Tile7_over_vertical_wall"]

func _ready():
	BottomTileMap = get_node("BottomTileMap")
	TopTileMap = get_node("TopTileMap")
	for i in range(0, 128):
		flat_not_walkable.push_back(not_walkable.has(i))
	# NOTE: -1 is "not walkable". This means that it should be "true" in
	# flat_not_walkable. However, the -1'th element of an array is its last
	# element. So for this special case, we add "true" to the end of the array
	# to ensure that flat_not_walkable[-1] == true.
	flat_not_walkable.push_back(true)
	GameData.tilemap = self
	set_map_type(GameData.chosen_map)
  
func next_level():
	points = {}
	ids = {}
	set_map_type(GameData.chosen_map)

func addPoint(i, j):
	var vec = Vector3(i, j, 0)
	if !points.has(vec):
		var id = Pathfinder.get_available_point_id()
		points[vec] = id
		ids[id] = vec
		Pathfinder.add_point(id, vec)

func connectPointHorizontalAndVertical(i, j):
	var vec = Vector3(i, j, 0)
	if points.has(vec):
		var id = points[vec]
		
		var point_right = Vector3(i+1, j, 0)
		var point_down = Vector3(i, j+1, 0)
		
		if points.has(point_right):
			Pathfinder.connect_points(id, points[point_right], true)
		if points.has(point_down):
			Pathfinder.connect_points(id, points[point_down], true)
			
		connectPointsUpAndLeft(i, j)

func connectPointsUpAndLeft(i, j):
	var vec = Vector3(i, j, 0)
	if points.has(vec):
		var id = points[vec]
		
		var point_left = Vector3(i-1, j, 0)
		var point_up = Vector3(i, j-1, 0)
		
		if points.has(point_left):
			Pathfinder.connect_points(id, points[point_left], true)
		if points.has(point_up):
			Pathfinder.connect_points(id, points[point_up], true)

func disconnectPoint(i, j):
	var point = Vector3(i, j, 0)
	var point_left = Vector3(i-1, j, 0)
	var point_up = Vector3(i, j-1, 0)
	var point_right = Vector3(i+1, j, 0)
	var point_down = Vector3(i, j+1, 0)
	
	if points.has(point):
		if points.has(point_left):
			Pathfinder.disconnect_points(points[point], points[point_left])
		if points.has(point_up):
			Pathfinder.disconnect_points(points[point], points[point_up])
		if points.has(point_right):
			Pathfinder.disconnect_points(points[point], points[point_right])
		if points.has(point_down):
			Pathfinder.disconnect_points(points[point], points[point_down])

func set_map_type(type):
	if has_node("BottomTileMap"):
		GameAnalytics.queue_progress_event("Start:" + str(GameData.current_level))
		map = Maps[type].new(GameData.current_level)
		var BTM = self.get_node("BottomTileMap")
		var TTM = self.get_node("TopTileMap")
		TTM.clear()
		var Enemies = self.get_node("/root/Node2D/Enemies")
		Pathfinder = AStar.new()
		var counting = 0
		var j = -100
		for row in map.tiles:
			var i = -100
			for tile in row:
				if tile == -1:
					BTM.set_cell(i, j, NON_PLAYABLE_TILES_NUMBER)
				else:
					BTM.set_cell(i, j, tile)
				
				if tile in top_layer_tiles:
					TTM.set_cell(i, j, tile_to_top_tile(tile))
				
				if !flat_not_walkable[tile]:
					counting += 1
					addPoint(i, j)
					connectPointsUpAndLeft(i, j)
				i = i + 1
			j = j + 1
		
		for enemy in map.npcs:
			var node = enemy.value.instance()
			node.set_position((enemy.position - Vector2(100.0, 100.0)) * 128.0)
			Enemies.add_child(node)
			node.isPartOfBossRoom = enemy.isPartOfBossRoom
			
			if type == "Tutorial":
				if node.character_name == "Zombie":
					node.item_distribution = null
				elif node.character_name == "Training Dummy":
					node.item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.FoodClasses.Apple}])
		
		for item in map.items:
			var node = item.value.new()
			node.place((item.position - Vector2(100.0, 100.0)) * 128.0)

		for env in map.environmentObjects:
			var Environments = self.get_node("/root/Node2D/Environments")
			var node = env.value.instance()
			node.set_position((env.position - Vector2(100, 100)) * 128)
			Environments.add_child(node)

			# Insert the node at the correct position, sorted by y coordinate, to prevent overdraw
			var children = Environments.get_children()
			var i = 0

			while i < children.size() and (children[i] == node or children[i].get_position().y < node.get_position().y):
				i += 1

			if i >= children.size() or children[i].get_position().y > node.get_position().y:
				i = max(0, i - 1)

			Environments.move_child(node, i)
			
			if env.has("facing"):
				node.setFacing(env.facing)
			
			if node.environment_name != null and "Chest" in node.environment_name:
				node.setLocked(false)
				node.blockFromPathFindingWhenReady = true
				if type == "Tutorial":
					node.setDistribution(Distribution.new([{"p": 1.0, "value": Constants.WeaponClasses.Bomb}]))
			elif node.environment_name == "Door":
				node.setLocked(false)
			elif node.environment_name == "BossDoor":
				node.setLocked(false)
				for character in GameData.characters:
					if character.isPartOfBossRoom:
						node.connect("bossDoorOpened", character, "_on_BossDoor_bossDoorOpened")

			GameData.environmentObjects.append(node)
	
	map_type = type

func get_map_type():
	return map_type

func walkable(x, y):
	var cell = BottomTileMap.get_cell(x, y)
	return !not_walkable.has(cell)

func _getIdPath(a, b):
	var a_vec3 = Vector3(a.x, a.y, 0)
	var b_vec3 = Vector3(b.x, b.y, 0)
	
	if (!points.has(a_vec3) || !points.has(b_vec3)):
		return null;
	
	var a_id = points[a_vec3]
	var b_id = points[b_vec3]
	
	return Pathfinder.get_id_path(a_id, b_id)

func findPath(a, b):
	var id_path = _getIdPath(a, b)
	
	if id_path == null:
		return []
	
	var path = []
	
	for id in id_path:
		var point_vec3 = ids[id]
		path.push_back(Vector2(point_vec3.x, point_vec3.y))
	
	return path

func findNextDirection(a, b):
	var id_path = _getIdPath(a, b)
	
	var direction = Enums.DIRECTION.NONE
	if id_path and id_path.size() > 1:
		direction = ids[id_path[1]] - ids[id_path[0]]
		if direction.x == 1:
			direction = Enums.DIRECTION.RIGHT
		elif direction.x == -1:
			direction = Enums.DIRECTION.LEFT
		elif direction.y == 1:
			direction = Enums.DIRECTION.DOWN
		elif direction.y == -1:
			direction = Enums.DIRECTION.UP
	return direction

func pathContainsClosedDoor(a, b):
	var path = findPath(a, b)
	
	for coords in path:
		for env in GameData.environmentObjectAtPos(coords):
			if env.environment_name == "Door" && env.getState() == "closed":
				return true

func findPathDistance(a, b):
	var id_path = _getIdPath(a, b)
	
	if id_path == null:
		return -1
	
	return id_path.size() - 1

func _on_Environment_blockStateChanged(environmentObject, blockedState):
	var x = environmentObject.position.x / GameData.TileSize
	var y = environmentObject.position.y / GameData.TileSize
	
	if blockedState:
		disconnectPoint(x, y)
	else:
		addPoint(x, y)
		connectPointHorizontalAndVertical(x, y)

