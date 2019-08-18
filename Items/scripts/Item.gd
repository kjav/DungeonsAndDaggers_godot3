extends Node2D

signal ItemUsed(item)
var texture
var description
var item_name
var iconFilePath
var useSound

func onUse():
	emit_signal("ItemUsed", self);

func place(newPos):
	position = newPos
	GameData.placeItem(self)

func pickup():
	GameData.pickedUp(self)
