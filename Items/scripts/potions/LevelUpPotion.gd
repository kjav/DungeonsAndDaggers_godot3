extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/special_potion.webp"
	item_name = "Level Up"
	texture = preload("res://assets/special_potion.webp")
	rarity = Enums.WEAPONRARITY.RARE

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.hud.show_upgrade_menu()
	.onUse()
