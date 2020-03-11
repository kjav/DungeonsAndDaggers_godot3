extends "UncommonDagger.gd"

func _init():
	textureFilePath = "res://assets/rare-dagger.png"
	texture = preload("res://assets/rare-dagger.png")
	iconTexture = preload("res://assets/rare-dagger-icon.png")
	iconTextureFilePath = "res://assets/rare-dagger-icon.png"
	item_name = "Rare Dagger"
	damage = 1.5
	rarity = Enums.WEAPONRARITY.RARE
