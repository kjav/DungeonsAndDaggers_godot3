extends "CommonBow.gd"

func _init():
	textureFilePath = "res://assets/basic_bow.png"
	texture = preload("res://assets/basic_bow.png")
	item_name = "Uncommon Bow"
	rarity = Enums.WEAPONRARITY.UNCOMMON
	ammo = 6