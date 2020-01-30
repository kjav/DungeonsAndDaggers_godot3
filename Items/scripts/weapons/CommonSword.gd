extends "WeaponBase.gd"

func _init():
	textureFilePath = "res://assets/basic_sword.png"
	texture = preload("res://assets/basic_sword.png")
	iconTexture = preload("res://assets/basic_sword.png")
	item_name = "Common Sword"
	damage = 2.5
	showBehindHand = true
	offset = Vector2(-30, -30)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)
