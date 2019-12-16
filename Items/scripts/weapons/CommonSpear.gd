extends "WeaponBase.gd"

func _init():
	iconFilePath = "res://assets/basic_spear.png"
	texture = preload("res://assets/basic_spear.png")
	item_name = "Common Spear"
	relativeAttackPositions = [Vector2(0, -1)]
	damage = 1
	onlyAttacksFirstEnemy = false
	showBehindHand = true
	offset = Vector2(-30, -30)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)
