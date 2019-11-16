extends Node2D

signal ItemUsed(item)
var texture
var description
var item_name
var iconFilePath
var useSound

func onUse():
	if not allowedToUse():
		return
	
	emit_signal("ItemUsed", self);

func place(newPos):
	position = newPos
	GameData.placeItem(self)

func pickup():
	GameData.pickedUp(self)

func allowedToUse():
	return not (GameData.player.moving or GameData.player.charactersAwaitingMove or GameData.charactersMoving())