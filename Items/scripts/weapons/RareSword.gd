extends "UncommonSword.gd"

func _init():
	iconFilePath = "res://assets/basic_sword.png"
	texture = preload("res://assets/basic_sword.png")
	item_name = "Rare Sword"
	damage = 4
	rarity = Enums.WEAPONRARITY.RARE
