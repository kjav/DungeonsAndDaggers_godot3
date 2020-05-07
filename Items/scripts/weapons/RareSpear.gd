extends "UncommonSpear.gd"

func _init():
	textureFilePath = "res://assets/rare-spear.png"
	texture = preload("res://assets/rare-spear.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/rare-spear-icon.png"
	iconTexture = preload("res://assets/rare-spear-icon.png")
	item_name = "Rare Spear"
	item_description = "Spears can attack up to 2 tiles away and penetrate multiple enemies. Rare deals damage of base 2.5."
	damage = 2.5
	rarity = Enums.WEAPONRARITY.RARE
