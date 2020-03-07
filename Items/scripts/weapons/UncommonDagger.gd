extends "CommonDagger.gd"

func _init():
	textureFilePath = "res://assets/basic_dagger.png"
	texture = preload("res://assets/basic_dagger.png")
	item_name = "Uncommon Dagger"
	damage = 1
	rarity = Enums.WEAPONRARITY.UNCOMMON