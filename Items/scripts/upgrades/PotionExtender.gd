extends "UpgradeBase.gd"

func _init():
	._init()
	texture = preload("res://assets/16_a.webp")
	textureFilePath = "res://assets/16_a.webp"
	description="Learn to make the most of potions, brief potions will now last much longer.\n\n  +Extended Brief Potions"
	title="Long Potions"

func onUse():
	GameData.player.extendBriefPotions = true
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.ExtendedBriefPotions)
