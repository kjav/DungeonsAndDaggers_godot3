extends "CommonSpear.gd"

func _init():
	textureFilePath = "res://assets/uncommon-spear.png"
	texture = preload("res://assets/uncommon-spear.png")
	iconTexture = preload("res://assets/uncommon-spear-icon.png")
	iconTextureFilePath = "res://assets/uncommon-spear-icon.png"
	item_name = "Uncommon Spear"
	damage = 2
	rarity = Enums.WEAPONRARITY.UNCOMMON
