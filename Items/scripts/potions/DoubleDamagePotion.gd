extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/black_potion.webp"
	item_name = "Double Damage"
	texture = preload("res://assets/black_potion.webp")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	.onUse()
	GameData.player.applyDamageModifier(2)