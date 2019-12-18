extends "CommonSpear.gd"

func _init():
	iconFilePath = "res://assets/basic_spear.png"
	texture = preload("res://assets/basic_spear.png")
	item_name = "Uncommon Spear"
	damage = 2
	rarity = Enums.WEAPONRARITY.UNCOMMON
