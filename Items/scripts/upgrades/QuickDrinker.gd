extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/40_a.webp")
	textureFilePath = "res://assets/40_a.webp"
	description="Become a quick drinker. Potions can be drunk as quick as you can click, without using up a turn.\n\n  +Quick Drinking"
	title="Quick Drinking"

func onUse():
	GameData.player.potionUsesTurn = false
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.QuickDrinking)
