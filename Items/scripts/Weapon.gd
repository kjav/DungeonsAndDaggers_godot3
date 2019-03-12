extends "Item.gd"

var damage
var distance
#Down, Up, Left, Right
var holdOffset
var relativeAttackPositions = []
var onlyAttacksFirstEnemy = true
var attackPositionBlockable = true

#can be used for things like bows later on
func onUse():
	pass

func pickup():
	.pickup()
	GameData.player.dropWeapon()
	GameData.player.setPrimaryWeapon(self)
