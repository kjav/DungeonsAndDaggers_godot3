extends "../Item.gd"

var damage
var distance
var relativeAttackPositions = []
var onlyAttacksFirstEnemy = true
var attackPositionBlockable = true
var showBehindHand = false
var isMelee = false
var offset = Vector2(0, 0)
var rotationInHand = 0
var rotationInOffHand = 0
var ammo = -1
var equiptable = true
var iconTexture
var iconTextureFilePath
var doesDamage = true

func onAttack(character):
	if ammo > 0:
		ammo -= 1

func onPlayerDamaged():
	pass

func pickup():
	.pickup()
	GameData.player.pickUpWeapon(self)

func onWalkedOut():
	pass