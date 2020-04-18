extends Node2D

signal ItemUsed(item)
var texture
var textureFilePath
var item_description = ""
var item_name = ""
var useSound
var rarity = Enums.WEAPONRARITY.COMMON

func onUse():
	emit_signal("ItemUsed", self);
	GameData.total_items_used += 1

func place(newPos):
	position = newPos
	GameData.placeItem(self)

func pickup():
	GameData.pickedUp(self)

func allowedToUse():
	return not (GameData.player.moving or GameData.player.charactersAwaitingMove or GameData.charactersMoving())

func tryAgainOnTurnEnd():
	GameData.player.connect("turnEnd",self,"onUse", [], CONNECT_ONESHOT)
