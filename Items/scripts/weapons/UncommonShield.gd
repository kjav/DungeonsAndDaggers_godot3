extends "CommonShield.gd"

func _init():
	chanceToBlockOutOf = 4
	textureFilePath = "res://assets/uncommon-shield.png"
	texture = preload("res://assets/uncommon-shield.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/uncommon-shield-icon.png"
	iconTexture = preload("res://assets/uncommon-shield-icon.png")
	item_name = "Uncommon Shield"
	rarity = Enums.WEAPONRARITY.UNCOMMON
