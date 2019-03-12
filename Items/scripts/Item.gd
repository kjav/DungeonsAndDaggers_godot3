extends Node2D

var description
var item_name
var iconFilePath
var pos = null
var useSound

func onUse():
	pass

func place(newPos):
	pos = newPos
	GameData.placeItem(self)

func pickup():
	GameData.pickedUp(self)
