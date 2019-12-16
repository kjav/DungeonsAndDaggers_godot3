extends "CommonShield.gd"

func _init():
	chanceToBlockOutOf = 6
	iconFilePath = "res://assets/basic_shield.png"
	texture = preload("res://assets/basic_shield.png")
	item_name = "Uncommon Shield"
	rarity = Enums.WEAPONRARITY.UNCOMMON
