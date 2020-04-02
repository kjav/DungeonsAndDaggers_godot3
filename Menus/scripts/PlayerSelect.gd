extends Node2D

var _item_names = ["BeserkerPlayer", "AngelPlayer", "WarriorPlayer"]
var _items = []
export var transitioning = false setget setTransitioning, getTransitioning

func get_items():
	for i in range(_item_names.size()):
		if typeof(_item_names[i]) == typeof("") and has_node(_item_names[i]):
			_items.append(get_node(_item_names[i]))
	return _items

func _on_changed(index):
	GameData.chosen_player = _item_names[index]

func setTransitioning(_transitioning):
	if has_node("SelectScreen"):
		get_node("SelectScreen").active = not _transitioning

func getTransitioning():
	pass
