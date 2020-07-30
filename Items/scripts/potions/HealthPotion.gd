extends "PotionBase.gd"

func _init():
	._init()
	textureFilePath = "res://assets/red_potion2.png"
	item_name = "Health"
	item_description = "Increases your maximum health by 1."
	useSound = "HealthPotion_Drink"
	texture = preload("res://assets/red_potion2.png")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.increaseMaxHealth(1)
	.onUse()
