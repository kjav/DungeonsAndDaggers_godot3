extends "UncommonDagger.gd"

func _init():
	textureFilePath = "res://assets/rare-dagger.png"
	texture = preload("res://assets/rare-dagger.png")
	offhandTexture = preload("res://assets/rare-dagger-offhand.png")
	offhandTextureFilePath = "res://assets/rare-dagger-offhand.png"
	iconTexture = preload("res://assets/rare-dagger.png")
	iconTextureFilePath = "res://assets/rare-dagger.png"
	item_name = "Rare Dagger"
	damage = 1.5
	rarity = Enums.WEAPONRARITY.RARE
