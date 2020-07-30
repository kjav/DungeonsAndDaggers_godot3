extends "CommonSpear.gd"

func _init():
	._init()
	textureFilePath = "res://assets/uncommon-spear.png"
	texture = preload("res://assets/uncommon-spear.png")
	offhandTexture = preload("res://assets/uncommon-spear-offhand.png")
	offhandTextureFilePath = "res://assets/uncommon-spear-offhand.png"
	iconTexture = preload("res://assets/uncommon-spear-icon.png")
	iconTextureFilePath = "res://assets/uncommon-spear-icon.png"
	item_name = "Uncommon Spear"
	item_description = "Spears can attack up to 2 tiles away and penetrate multiple enemies. Uncommon deals damage of base 2."
	damage = 2
	rarity = Enums.WEAPONRARITY.UNCOMMON
