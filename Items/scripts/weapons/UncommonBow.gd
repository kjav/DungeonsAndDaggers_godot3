extends "CommonBow.gd"

func _init():
	textureFilePath = "res://assets/uncommon-bow.png"
	texture = preload("res://assets/uncommon-bow.png")
	item_name = "Uncommon Bow"
	rarity = Enums.WEAPONRARITY.UNCOMMON
	ammo = 6