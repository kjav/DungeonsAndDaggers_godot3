extends "CommonBow.gd"

func _init():
	iconFilePath = "res://assets/basic_bow.png"
	texture = preload("res://assets/basic_bow.png")
	item_name = "Uncommon Bow"
	damage = 1
	rarity = Enums.WEAPONRARITY.UNCOMMON
