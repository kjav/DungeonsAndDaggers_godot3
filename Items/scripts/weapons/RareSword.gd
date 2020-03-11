extends "UncommonSword.gd"

func _init():
	textureFilePath = "res://assets/rare-sword.png"
	texture = preload("res://assets/rare-sword.png")
	iconTextureFilePath = "res://assets/rare-sword-icon.png"
	iconTexture = preload("res://assets/rare-sword-icon.png")
	item_name = "Rare Sword"
	damage = 3.5
	rarity = Enums.WEAPONRARITY.RARE
