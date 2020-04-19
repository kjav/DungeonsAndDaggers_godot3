extends "WeaponBase.gd"

func _init():
	textureFilePath = "res://assets/basic_dagger.png"
	texture = preload("res://assets/basic_dagger.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTexture = preload("res://assets/basic_dagger.png")
	iconTextureFilePath = "res://assets/basic_dagger.png"
	item_name = "Common Dagger"
	item_description = "Daggers work in your offhand and may add an additional attack to adjecent tiles. Common has a base damage of 0.5."
	damage = 0.5
	isMelee = true
	showBehindHand = true
	isOffhand = true
	offset = Vector2(-20, -15)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)
