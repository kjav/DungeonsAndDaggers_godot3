extends "CommonSword.gd"

func _init():
	textureFilePath = "res://assets/basic_sword.png"
	texture = preload("res://assets/basic_sword.png")
	item_name = "Uncommon Sword"
	damage = 3
	rarity = Enums.WEAPONRARITY.UNCOMMON