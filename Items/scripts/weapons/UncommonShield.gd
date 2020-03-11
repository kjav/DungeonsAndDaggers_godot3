extends "CommonShield.gd"

func _init():
	chanceToBlockOutOf = 5
	textureFilePath = "res://assets/uncommon-shield.png"
	texture = preload("res://assets/uncommon-shield.png")
	item_name = "Uncommon Shield"
	rarity = Enums.WEAPONRARITY.UNCOMMON
