extends "CommonDagger.gd"

func _init():
	textureFilePath = "res://assets/uncommon-dagger.png"
	texture = preload("res://assets/uncommon-dagger.png")
	item_name = "Uncommon Dagger"
	damage = 1
	rarity = Enums.WEAPONRARITY.UNCOMMON