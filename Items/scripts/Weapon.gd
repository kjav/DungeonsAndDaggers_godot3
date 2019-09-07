extends "Item.gd"

var damage
var distance
var relativeAttackPositions = []
var onlyAttacksFirstEnemy = true
var attackPositionBlockable = true
var showBehindHand = false

#can be used for things like bows later on
func onUse():
	pass

func pickup():
	.pickup()
	GameData.player.dropWeapon()
	GameData.player.setPrimaryWeapon(self)
