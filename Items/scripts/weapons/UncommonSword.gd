extends "CommonSword.gd"

func _init():
	textureFilePath = "res://assets/uncommon-sword.png"
	texture = preload("res://assets/uncommon-sword.png")
	iconTextureFilePath = "res://assets/uncommon-sword.png"
	iconTexture = preload("res://assets/uncommon-sword.png")
	item_name = "Uncommon Sword"
	damage = 3
	rarity = Enums.WEAPONRARITY.UNCOMMON