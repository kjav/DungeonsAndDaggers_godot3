extends "UncommonDagger.gd"

func _init():
	textureFilePath = "res://assets/rare-dagger.png"
	texture = preload("res://assets/rare-dagger.png")
	item_name = "Rare Dagger"
	damage = 1.5
	rarity = Enums.WEAPONRARITY.RARE
