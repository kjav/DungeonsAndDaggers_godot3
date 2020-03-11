extends "UncommonSword.gd"

func _init():
	textureFilePath = "res://assets/rare-sword.png"
	texture = preload("res://assets/rare-sword.png")
	item_name = "Rare Sword"
	damage = 3.5
	rarity = Enums.WEAPONRARITY.RARE
