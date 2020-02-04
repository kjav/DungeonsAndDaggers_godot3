extends "CommonShield.gd"

func _init():
	chanceToBlockOutOf = 5
	textureFilePath = "res://assets/basic_shield.webp"
	texture = preload("res://assets/basic_shield.webp")
	item_name = "Uncommon Shield"
	rarity = Enums.WEAPONRARITY.UNCOMMON
