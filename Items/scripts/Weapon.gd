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
var ammo = -1

func onAttack(character):
	if ammo > 0:
		ammo -= 1
	pass

func onPlayerDamaged():
	pass

func pickup():
	.pickup()
	GameData.player.dropWeapon()
	GameData.player.setCurrentWeapon(self)
