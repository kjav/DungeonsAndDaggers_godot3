extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/special_potion.webp"
	item_name = "Level Up"
	texture = preload("res://assets/special_potion.webp")
	rarity = Enums.WEAPONRARITY.RARE

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	.onUse()
	GameData.hud.show_upgrade_menu()
