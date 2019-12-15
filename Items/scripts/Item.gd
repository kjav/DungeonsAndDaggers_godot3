extends Node2D

signal ItemUsed(item)
var texture
var description
var item_name
var iconFilePath
var useSound
var rarity = Enums.WEAPONRARITY.COMMON

func onUse():
	emit_signal("ItemUsed", self);
	GameData.player.forceTurnEnd()

func place(newPos):
	position = newPos
	GameData.placeItem(self)

func pickup():
	GameData.pickedUp(self)

func allowedToUse():
	return not (GameData.player.moving or GameData.player.charactersAwaitingMove or GameData.charactersMoving())

func tryAgainOnTurnEnd():
	GameData.player.connect("turnEnd",self,"onUse", [], CONNECT_ONESHOT)