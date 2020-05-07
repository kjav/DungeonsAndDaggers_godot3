extends "WeaponBase.gd"

func _init():
	textureFilePath = "res://assets/basic_spear.png"
	texture = preload("res://assets/basic_spear.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/basic-spear-icon.png"
	iconTexture = preload("res://assets/basic-spear-icon.png")
	item_name = "Common Spear"
	item_description = "Spears can attack up to 2 tiles away and penetrate multiple enemies. Common deals damage of base 1.5."
	relativeAttackPositions = [Vector2(0, -1)]
	onlyAttacksFirstEnemy = false
	damage = 1.5
	isMelee = true
	showBehindHand = true
	offset = Vector2(-30, -50)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)
