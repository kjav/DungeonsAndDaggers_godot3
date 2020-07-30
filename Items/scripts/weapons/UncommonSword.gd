extends "CommonSword.gd"

func _init():
	._init()
	textureFilePath = "res://assets/uncommon-sword.png"
	texture = preload("res://assets/uncommon-sword.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/uncommon-sword.png"
	iconTexture = preload("res://assets/uncommon-sword.png")
	item_name = "Uncommon Sword"
	item_description = "Swords attack adjecent tiles only. Uncommon deals damage of base 3."
	damage = 3
	rarity = Enums.WEAPONRARITY.UNCOMMON
