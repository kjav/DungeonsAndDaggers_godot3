extends "UncommonShield.gd"

func _init():
	chanceToBlockOutOf = 4
	textureFilePath = "res://assets/basic_shield.png"
	texture = preload("res://assets/basic_shield.png")
	item_name = "Rare Shield"
	rarity = Enums.WEAPONRARITY.RARE