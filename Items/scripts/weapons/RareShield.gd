extends "UncommonShield.gd"

func _init():
	chanceToBlockOutOf = 4
	iconFilePath = "res://assets/basic_shield.webp"
	texture = preload("res://assets/basic_shield.webp")
	item_name = "Rare Shield"
	rarity = Enums.WEAPONRARITY.RARE
