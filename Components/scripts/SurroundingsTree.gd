extends "res://Components/scripts/Tree.gd"

#TODO: Implement tree as an array, with position n having 2^n children at positions 2*2^n, 2*2^n + 1, ..., 2*2^n + n
var tree_array = []

func _init(depth):
	for i in range(0, pow(2, depth + 1) - 1):
		tree_array.push_back(41)

func depths_0(tree_indices):
	for i in tree_indices:
		if 2 * i + 1 >= tree_array.size():
			return true
	return false

func add_value(position, val):
	var index = 0
	var tree_indices = [0]
	while (!depths_0(tree_indices)) and (index < position.size()):
		var dir = position[index]
		var new_trees = []
		if dir == null:
			for tree_index in tree_indices:
				new_trees.append(2 * tree_index + 1)
				new_trees.append(2 * tree_index + 2)
		elif dir:
			for tree_index in tree_indices:
				new_trees.append(2 * tree_index + 1)
		else:
			for tree_index in tree_indices:
				new_trees.append(2 * tree_index + 2)
		tree_indices = new_trees
		index += 1
	for tree_index in tree_indices:
		tree_array[tree_index] = val

func get_value(position):
	var tree_index = 0
	var index = 0
	var last_value = null
	while (2 * tree_index + 1 < tree_array.size()) and (index < position.size()):
		if position[index]:
			tree_index = 2 * tree_index + 1
		else:  
			tree_index = 2 * tree_index + 2
		if tree_array[tree_index] != null:
			last_value = tree_array[tree_index]
		index += 1
	return last_value
