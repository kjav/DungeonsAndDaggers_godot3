extends "UncommonBow.gd"

func _init():
	iconFilePath = "res://assets/basic_bow.png"
	texture = preload("res://assets/basic_bow.png")
	item_name = "Rare Bow"
	damage = 1.5
	rarity = Enums.WEAPONRARITY.RARE
