extends Node2D

var Distribution = Constants.Distribution

export(int) var bottom_z_index = 0
export(int) var top_z_index = 2
export(int, "Basic Dungeon", "Maze Dungeon") var map_type = 0 setget set_map_type, get_map_type

var Maps = {
  "DungeonMap": load("res://Components/scripts/TestMap2.gd"),
  "TestMap": load("res://Components/scripts/TestMap.gd")
}

var not_walkable = [-1, 6, 13, 21, 22, 23, 25, 26, 27, 28, 30, 32, 33, 34, 35, 39, 41, 42]
# This array is a boolean array, with elements at positions in the above array
# set to true, and all other elements false.
var flat_not_walkable = []

var Pathfinder
var points = {}
var ids = {}
var map = null

var top_layer_tiles = []

var BottomTileMap

func _ready():
	print("YOOOOOOOO")
	BottomTileMap = get_node("BottomTileMap")
	for i in range(0, 128):
		flat_not_walkable.push_back(not_walkable.has(i))
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
		map = Maps[type].new()
		var BTM = self.get_node("BottomTileMap")
		var TTM = self.get_node("BottomTileMap")
		var Enemies = self.get_node("/root/Node2D/Enemies")
		Pathfinder = AStar.new()
		GameData.tilemap = self
		
		var j = -100
		for row in map.tiles:
			var i = -100
			for tile in row:
				BTM.set_cell(i, j, tile)
				
				if tile in top_layer_tiles:
					TTM.set_cell(i, j, tile)
				
				if !flat_not_walkable[tile]:
					addPoint(i, j)
					connectPointsUpAndLeft(i, j)
				i = i + 1
			j = j + 1
		
		for enemy in map.npcs:
			var node = enemy.value.instance()
			Enemies.add_child(node)
			node.set_position((enemy.position - Vector2(100.0, 100.0)) * 128.0)
			node.isPartOfBossRoom = enemy.isPartOfBossRoom
		
		for item in map.items:
			var node = item.value.new()
			node.place((item.position - Vector2(100.0, 100.0)) * 128.0)

		for env in map.environmentObjects:
			var Environments = self.get_node("/root/Node2D/Environments")
			var node = env.value.instance()
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
			
			if env != null:
				if node != null:
					if node.environment_name != null:
						print("Nodes name: " + node.environment_name)
						print(env.has("facing"))
			
			if node.environment_name == "Chest":
				node.setLocked(true)
				node.setUnlockGuid("Silver")
				node.setDistribution(Distribution.new([{"p": 1.0, "value": Constants.WeaponClasses.BasicSpear}]))
			elif node.environment_name == "Door":
				node.setLocked(false)
			elif node.environment_name == "BossDoor":
				node.setLocked(false)
				for character in GameData.characters:
					if character.isPartOfBossRoom:
						node.connect("bossDoorOpened", character, "_on_BossDoor_bossDoorOpened")

			GameData.environmentObjects.append(node)
			node.set_position((env.position - Vector2(100, 100)) * 128)
	
	map_type = type

func get_map_type():
	return map_type

func walkable(x, y):
	var cell = BottomTileMap.get_cell(x, y)
	return !not_walkable.has(cell)

func findPath(a, b):
	var a_vec3 = Vector3(a.x, a.y, 0)
	var b_vec3 = Vector3(b.x, b.y, 0)
	
	var a_id = points[a_vec3]
	var b_id = points[b_vec3]
	
	var id_path = Pathfinder.get_id_path(a_id, b_id)
	
	var path = []
	
	for id in id_path:
		var point_vec3 = ids[id]
		path.push_back(Vector2(point_vec3.x, point_vec3.y))
	
	return path

func findNextDirection(a, b):
	var a_vec3 = Vector3(a.x, a.y, 0)
	var b_vec3 = Vector3(b.x, b.y, 0)
	
	var a_id = points[a_vec3]
	var b_id = points[b_vec3]
	
	#print("Getting id path ", a_vec3, ", ", b_vec3)
	
	var id_path = Pathfinder.get_id_path(a_id, b_id)
	
	#print("Got id path ", a_vec3, ", ", b_vec3, ". Length: ", id_path.size())
	
	var direction = Enums.DIRECTION.NONE
	if id_path.size() > 1:
		direction = ids[id_path[1]] - ids[id_path[0]]
		print(direction)
		if direction.x == 1:
			direction = Enums.DIRECTION.RIGHT
		elif direction.x == -1:
			direction = Enums.DIRECTION.LEFT
		elif direction.y == 1:
			direction = Enums.DIRECTION.DOWN
		elif direction.y == -1:
			direction = Enums.DIRECTION.UP
	return direction

func _on_Environment_blockStateChanged(environmentObject, blockedState):
	var x = environmentObject.position.x / GameData.TileSize
	var y = environmentObject.position.y / GameData.TileSize
	
	if blockedState:
		disconnectPoint(x, y)
	else:
		addPoint(x, y)
		connectPointHorizontalAndVertical(x, y)

