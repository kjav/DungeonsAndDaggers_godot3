extends "UncommonBow.gd"

func _init():
	textureFilePath = "res://assets/rare-bow.png"
	texture = preload("res://assets/rare-bow.png")
	item_name = "Rare Bow"
	damage = 1.5
	rarity = Enums.WEAPONRARITY.RARE
