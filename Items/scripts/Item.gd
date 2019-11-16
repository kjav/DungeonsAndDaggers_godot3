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

func allowedToUse():
	return not (GameData.player.moving or GameData.player.charactersAwaitingMove or GameData.charactersMoving())

func eventMessageForTurnUse():
	GameData.hud.addEventMessage("Can't use that while turn is completing.")