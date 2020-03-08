extends "WeaponBase.gd"

func _init():
	textureFilePath = "res://assets/basic_dagger.png"
	texture = preload("res://assets/basic_dagger.png")
	iconTexture = preload("res://assets/basic_dagger.png")
	iconTextureFilePath = "res://assets/basic_dagger.png"
	iconTexture = preload("res://assets/basic_dagger.png")
	item_name = "Common Dagger"
	damage = 0.5
	isMelee = true
	showBehindHand = true
	offset = Vector2(-25, -25)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)
