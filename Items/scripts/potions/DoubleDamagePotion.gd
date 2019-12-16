extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/black_potion.png"
	item_name = "Double Damage"
	texture = preload("res://assets/black_potion.png")
	rarity = Enums.WEAPONRARITY.RARE

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	.onUse()
	GameData.player.applyDamageModifier(3)