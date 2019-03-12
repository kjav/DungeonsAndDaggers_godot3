extends Node2D

export(int, "Full", "Half", "Empty") var type setget setType, getType

var full = preload("res://assets/heart.png")
var half = preload("res://assets/half_grey_heart.png")
var empty = preload("res://assets/grey_heart.png")

func setType(newType):
	type = newType
	if type == "Full":
		get_node("Heart").set_texture(full)
	elif type == "Half":
		get_node("Heart").set_texture(half)
	elif type == "Empty":
		get_node("Heart").set_texture(empty)

func getType():
	return type

