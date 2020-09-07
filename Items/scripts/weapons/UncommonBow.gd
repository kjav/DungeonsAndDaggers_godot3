extends "CommonBow.gd"

func _init():
	._init()
	textureFilePath = "res://assets/uncommon-bow.png"
	texture = preload("res://assets/uncommon-bow.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/uncommon-bow-icon.png"
	iconTexture = preload("res://assets/uncommon-bow-icon.png")
	item_name = "Uncommon Bow"
	item_description = "Bows hit the first enemy in a straight line at any distance and have at most 6 ammo.  Uncommon's base damage is 1.5."
	rarity = Enums.WEAPONRARITY.UNCOMMON
	damage = 1.5
