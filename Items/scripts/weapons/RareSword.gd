extends "UncommonSword.gd"

func _init():
	textureFilePath = "res://assets/rare-sword.png"
	texture = preload("res://assets/rare-sword.png")
	offhandTexture = preload("res://assets/rare-sword-offhand.png")
	offhandTextureFilePath = "res://assets/rare-sword-offhand.png"
	iconTextureFilePath = "res://assets/rare-sword-icon.png"
	iconTexture = preload("res://assets/rare-sword-icon.png")
	item_name = "Rare Sword"
	item_description = "Swords attack adjecent tiles only. Rare deals damage of base 3.5."
	damage = 3.5
	rarity = Enums.WEAPONRARITY.RARE
