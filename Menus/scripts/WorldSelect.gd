extends Node2D

var _item_names = ["Tutorial", "UndeadCrypt"]
var _test_item_names = ["TestOneEnemy", "TestManyEnemy", "TestManyItems", "TestUpgrades", "TestChests"]
var _items = []

func _init():
	if (GameData.TESTING):
		_item_names += _test_item_names

func get_items():
	for i in range(_item_names.size()):
		if typeof(_item_names[i]) == typeof("") and has_node(_item_names[i]):
			_items.append(get_node(_item_names[i]))
	return _items

func _on_changed(index):
	GameData.chosen_map = _item_names[index]
	GameData.chosen_player = "BeserkerPlayer"
