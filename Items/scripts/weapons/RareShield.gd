extends "UncommonShield.gd"

func _init():
	chanceToBlockOutOf = 4
	textureFilePath = "res://assets/rare-shield.png"
	texture = preload("res://assets/rare-shield.png")
	item_name = "Rare Shield"
	rarity = Enums.WEAPONRARITY.RARE
