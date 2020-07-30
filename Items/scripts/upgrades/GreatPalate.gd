extends "UpgradeBase.gd"

func _init():
	._init()
	texture = preload("res://assets/26_a.webp")
	textureFilePath = "res://assets/26_a.webp"
	description="Develop a sophisticated Palate. Uncommon food will heal you an extra half a heart.\n\n  +Sophisticated Palate"
	title="Great Palate"

func onUse():
	GameData.player.increasedFoodHeal = true
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.SophisticatedPalate)
