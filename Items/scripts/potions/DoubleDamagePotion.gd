extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/black_potion.png"
	item_name = "Double Damage"
	texture = preload("res://assets/black_potion.png")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyDamageModifier(2)
	.onUse()