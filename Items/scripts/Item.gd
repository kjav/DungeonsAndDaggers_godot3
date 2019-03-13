extends Node2D

var description
var item_name
var iconFilePath
var useSound

func onUse():
	pass

func place(newPos):
	position = newPos
	GameData.placeItem(self)

func pickup():
	GameData.pickedUp(self)
