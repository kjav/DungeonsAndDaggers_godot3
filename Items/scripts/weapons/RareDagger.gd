extends "UncommonDagger.gd"

func _init():
	._init()
	textureFilePath = "res://assets/rare-dagger.png"
	texture = preload("res://assets/rare-dagger.png")
	offhandTexture = preload("res://assets/rare-dagger-offhand.png")
	offhandTextureFilePath = "res://assets/rare-dagger-offhand.png"
	iconTexture = preload("res://assets/rare-dagger.png")
	iconTextureFilePath = "res://assets/rare-dagger.png"
	item_name = "Rare Dagger"
	item_description = "Daggers work in your offhand and may add an additional attack to adjecent tiles. Rare has a base damage of 1.5."
	damage = 1.5
	rarity = Enums.WEAPONRARITY.RARE
