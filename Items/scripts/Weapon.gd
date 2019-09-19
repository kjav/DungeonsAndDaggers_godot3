extends "Item.gd"

var damage
var distance
var relativeAttackPositions = []
var onlyAttacksFirstEnemy = true
var attackPositionBlockable = true
var showBehindHand = false
var offset = Vector2(0, 0)
var rotationInHand = 0
var rotationInOffHand = 0

func onAttack(character):
	pass

func onPlayerDamaged():
	pass

func pickup():
	.pickup()
	GameData.player.dropWeapon()
	GameData.player.setPrimaryWeapon(self)
