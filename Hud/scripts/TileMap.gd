extends TileMap

var not_walkable = [-1, 6, 13, 21, 22, 23, 25, 26, 27, 28, 30, 32, 33, 34, 35]
var Pathfinder
var points = {}
var ids = {}

func _ready():
	var cells = load_csv("res://assets/maps/" + GameData.chosen_map + ".csv")
	for i in range(-100, 100):
		for j in range(-100, 100):
			self.set_cell(i, j, cells[j + 100][i + 100])
	#GameData.tilemap = self
	Pathfinder = AStar.new()
	var id
	var point_left
	var point_up
	for j in range(-100, 100):
		for i in range(-100, 100):
			if walkable(i, j):
				id = Pathfinder.get_available_point_id()
				points[Vector3(i, j, 0)] = id
				ids[id] = Vector3(i, j, 0)
				Pathfinder.add_point(id, Vector3(i, j, 0))
				point_left = Vector3(i-1, j, 0)
				point_up = Vector3(i, j-1, 0)
				if points.has(point_left):
					Pathfinder.connect_points(id, points[point_left], true)
				if points.has(point_up):
					Pathfinder.connect_points(id, points[point_up], true)

func save_csv(cells, path):
	var file = File.new()
	file.open(path, file.WRITE)
	for row in cells:
		var row_string = ""
		for cell in row:
			row_string = row_string + str(cell) + ","
		file.store_string(row_string + "\n")
	file.close()

func load_csv(path):
	var file = File.new()
	file.open(path, file.READ)
	var row_strings = file.get_as_text().split("\n")
	var cells = []
	for row_string in row_strings:
		if row_string.length() > 0:
			var row = []
			var cell_strings = row_string.split(",")
			for cell_string in cell_strings:
				if cell_string.length() > 0:
					row.append(int(cell_string))
			cells.append(row)
	file.close()
	return cells

func walkable(x, y):
	var cell = self.get_cell(x, y)
	return !~not_walkable.find(cell)

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
	
	var id_path = Pathfinder.get_id_path(a_id, b_id)
	
	var direction = Enums.DIRECTION.NONE
	
	if id_path.size() > 1:
		direction = ids[id_path[1]] - ids[id_path[0]]
		if direction.x == 1:
			direction = Enums.DIRECTION.RIGHT
		elif direction.x == -1:
			direction = Enums.DIRECTION.LEFT
		elif direction.y == 1:
			direction = Enums.DIRECTION.DOWN
		elif direction.y == -1:
			direction = Enums.DIRECTION.UP
		else:
			direction = Enums.DIRECTION.NONE
	
	return direction
