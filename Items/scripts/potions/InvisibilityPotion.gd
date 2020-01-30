extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/clear_potion.png"
	item_name = "Invisibility"
	texture = preload("res://assets/clear_potion.png")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyInvisibility(10)
	.onUse()