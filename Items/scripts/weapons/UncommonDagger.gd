extends "CommonDagger.gd"

func _init():
	._init()
	textureFilePath = "res://assets/uncommon-dagger.png"
	texture = preload("res://assets/uncommon-dagger.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/uncommon-dagger-icon.png"
	iconTexture = preload("res://assets/uncommon-dagger-icon.png")
	item_name = "Uncommon Dagger"
	item_description = "Daggers work in your offhand and may add an additional attack to adjecent tiles. Uncommon has a base damage of 1."
	damage = 1
	rarity = Enums.WEAPONRARITY.UNCOMMON
