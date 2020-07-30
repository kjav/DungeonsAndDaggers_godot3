extends "WeaponBase.gd"

func _init():
	._init()
	textureFilePath = "res://assets/common-sword.png"
	texture = preload("res://assets/common-sword.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTexture = preload("res://assets/common-sword.png")
	iconTextureFilePath = "res://assets/common-sword.png"
	item_name = "Common Sword"
	item_description = "Swords attack adjecent tiles only. Common deals damage of base 2.5."
	damage = 2.5
	isMelee = true
	showBehindHand = true
	offset = Vector2(-31, -25)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)
