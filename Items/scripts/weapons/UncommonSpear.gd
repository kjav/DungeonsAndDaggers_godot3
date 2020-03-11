extends "CommonSpear.gd"

func _init():
	textureFilePath = "res://assets/uncommon-spear.png"
	texture = preload("res://assets/uncommon-spear.png")
	item_name = "Uncommon Spear"
	damage = 2
	rarity = Enums.WEAPONRARITY.UNCOMMON
