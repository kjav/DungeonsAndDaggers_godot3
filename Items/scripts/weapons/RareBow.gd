extends "UncommonBow.gd"

func _init():
	textureFilePath = "res://assets/rare-bow.png"
	texture = preload("res://assets/rare-bow.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTexture = preload("res://assets/rare-bow-icon.png")
	iconTextureFilePath = "res://assets/rare-bow-icon.png"
	item_name = "Rare Bow"
	damage = 1.5
	rarity = Enums.WEAPONRARITY.RARE
