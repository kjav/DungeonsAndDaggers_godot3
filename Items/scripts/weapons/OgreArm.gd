extends "WeaponBase.gd"

func _init():
	textureFilePath = "res://assets/meat_club.png"
	texture = preload("res://assets/meat_club.png")
	iconTextureFilePath = "res://assets/meat_club.png"
	iconTexture = preload("res://assets/meat_club.png")
	item_name = "Ogre Arm"
	rarity = Enums.WEAPONRARITY.RARE
	isMelee = true
	showBehindHand = true
	damage = 3
	onlyAttacksFirstEnemy = false
	relativeAttackPositions = [Vector2(0, -1), Vector2(0, -2)]
	offset = Vector2(-35, -35)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)