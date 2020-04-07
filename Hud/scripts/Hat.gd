extends Sprite

enum {Full, Half, Empty}

export(int) var type setget setType, getType

var full = preload("res://assets/pixel.png")
var half = preload("res://assets/pixel.png")
var empty = preload("res://assets/pixel.png")

func setType(newType):
	type = newType
	if type == Full:
		texture = full
	elif type == Half:
		texture = half
	elif type == Empty:
		texture = empty

func getType():
	return type

