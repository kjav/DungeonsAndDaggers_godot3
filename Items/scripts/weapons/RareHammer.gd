extends "CommonHammer.gd"

func _init():
	._init()
	textureFilePath = "res://assets/Hammers/hammer_long.png"
	texture = preload("res://assets/Hammers/hammer_long.png")
	offhandTexture = preload("res://assets/Hammers/hammer_long.png")
	offhandTextureFilePath = "res://assets/Hammers/hammer_long.png"
	iconTexture = preload("res://assets/Hammers/long_hammer_icon.png")
	iconTextureFilePath = "res://assets/Hammers/long_hammer_icon.png"
	item_name = "Rare Hammer"
	item_description = "Hammers alternate between additionally attacking behind or to the sides of the target. Rare has a base damage of 2.5."
	damage = 2.5
	rarity = Enums.WEAPONRARITY.RARE
	offset = Vector2(-30, -50)
