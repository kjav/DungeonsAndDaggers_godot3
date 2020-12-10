extends "UncommonBow.gd"

func _init():
	._init()
	textureFilePath = "res://assets/rare-bow.png"
	texture = preload("res://assets/rare-bow.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTexture = preload("res://assets/rare-bow-icon.png")
	iconTextureFilePath = "res://assets/rare-bow-icon.png"
	item_name = "Rare Bow"
	item_description = "Bows hit the first enemy in a straight line at any distance and have at most 6 ammo. Rare's base damage is 2."
	damage = 2
	rarity = Enums.WEAPONRARITY.RARE
