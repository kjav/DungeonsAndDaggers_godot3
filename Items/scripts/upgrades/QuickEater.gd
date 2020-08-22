extends "UpgradeBase.gd"

func _init():
	._init()
	texture = preload("res://assets/40_a.webp")
	textureFilePath = "res://assets/40_a.webp"
	description="Become a quick eater. The first food you eat on a turn will not end it.\n\n  +Quick Eating"
	title="Quick Eating"

func onUse():
	GameData.player.firstFoodTurnFree = true
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.QuickEating)
