extends Node2D

export(int, "Full", "Half", "Empty") var type setget setType, getType

var full = preload("res://assets/hat.png")
var half = preload("res://assets/half_grey_hat.png")
var empty = preload("res://assets/grey_hat.png")

func setType(newType):
	type = newType
	if type == "Full":
		set_texture(full)
	elif type == "Half":
		set_texture(half)
	elif type == "Empty":
		set_texture(empty)

func getType():
	return type

