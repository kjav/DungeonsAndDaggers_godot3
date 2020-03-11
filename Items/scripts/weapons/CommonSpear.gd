extends "WeaponBase.gd"

func _init():
	textureFilePath = "res://assets/basic_spear.png"
	texture = preload("res://assets/basic_spear.png")
	iconTexture = preload("res://assets/clipped_basic_spear.png")
	iconTextureFilePath = "res://assets/clipped_basic_spear.png"
	iconTexture = preload("res://assets/clipped_basic_spear.png")
	item_name = "Common Spear"
	relativeAttackPositions = [Vector2(0, -1)]
	damage = 1.5
	isMelee = true
	showBehindHand = true
	offset = Vector2(-30, -50)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)
