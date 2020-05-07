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
	item_description = "Shields work in your offhand and may fully block attacks. Uncommon, on average, blocks 1 in 4 attacks."
	rarity = Enums.WEAPONRARITY.UNCOMMON
