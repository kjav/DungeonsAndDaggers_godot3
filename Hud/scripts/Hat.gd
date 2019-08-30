extends Sprite

enum {Full, Half, Empty}

export(int) var type setget setType, getType

var full = preload("res://assets/hat.png")
var half = preload("res://assets/half_grey_hat.png")
var empty = preload("res://assets/grey_hat.png")

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

