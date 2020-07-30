extends "PotionBase.gd"

func _init():
	._init()
	textureFilePath = "res://assets/clear_potion.webp"
	item_name = "Invisibility"
	item_description = "Turns you invisible for 10 turns or until you attack, enemies won't see you but may still bump into you."
	texture = preload("res://assets/clear_potion.webp")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyInvisibility(10)
	.onUse()
