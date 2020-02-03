extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/clear_potion.webp"
	item_name = "Invisibility"
	texture = preload("res://assets/clear_potion.webp")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	.onUse()
	GameData.player.applyInvisibility(10)
