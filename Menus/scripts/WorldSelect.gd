extends Node2D

var _item_names = ["Tutorial", "UndeadCrypt"]
var _items = []

func get_items():
	for i in range(_item_names.size()):
		if typeof(_item_names[i]) == typeof("") and has_node(_item_names[i]):
			_items.append(get_node(_item_names[i]))
	return _items

func _on_changed(index):
	GameData.chosen_map = _item_names[index]
	GameData.chosen_player = "BeserkerPlayer"
