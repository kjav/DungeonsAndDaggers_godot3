extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/red_potion2.png"
	item_name = "Health"
	useSound = "HealthPotion_Drink"
	texture = preload("res://assets/red_potion2.png")
	rarity = Enums.WEAPONRARITY.RARE

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.increaseMaxHealth(1)
	.onUse()