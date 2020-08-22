extends "UpgradeBase.gd"

func _init():
	._init()
	texture = preload("res://assets/40_a.webp")
	textureFilePath = "res://assets/40_a.webp"
	description="Become a quick drinker. The first potion you drink on a turn will not end it.\n\n  +Quick Drinking"
	title="Quick Drinking"

func onUse():
	GameData.player.firstPotionTurnFree = true
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.QuickDrinking)
