extends "CommonShield.gd"

func _init():
	chanceToBlockOutOf = 5
	textureFilePath = "res://assets/uncommon-shield.png"
	texture = preload("res://assets/uncommon-shield.png")
	iconTextureFilePath = "res://assets/uncommon-shield-icon.png"
	iconTexture = preload("res://assets/uncommon-shield-icon.png")
	item_name = "Uncommon Shield"
	rarity = Enums.WEAPONRARITY.UNCOMMON
