extends "UncommonDagger.gd"

func _init():
	textureFilePath = "res://assets/basic_dagger.png"
	texture = preload("res://assets/basic_dagger.png")
	item_name = "Rare Dagger"
	damage = 1.5
	rarity = Enums.WEAPONRARITY.RARE
