extends "UncommonSpear.gd"

func _init():
	textureFilePath = "res://assets/rare-spear.png"
	texture = preload("res://assets/rare-spear.png")
	item_name = "Rare Spear"
	damage = 2.5
	rarity = Enums.WEAPONRARITY.RARE
