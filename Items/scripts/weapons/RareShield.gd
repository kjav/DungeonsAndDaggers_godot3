extends "UncommonShield.gd"

func _init():
	chanceToBlockOutOf = 3
	textureFilePath = "res://assets/rare-shield.png"
	texture = preload("res://assets/rare-shield.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/rare-shield-icon.png"
	iconTexture = preload("res://assets/rare-shield-icon.png")
	item_name = "Rare Shield"
	item_description = "Shields work in your offhand and may fully block attacks. Rare, on average, blocks 1 in 3 attacks."
	rarity = Enums.WEAPONRARITY.RARE
