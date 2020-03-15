extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/26_a.webp")
	textureFilePath = "res://assets/26_a.webp"
	description="Develop a sophisticated Palate. Any non common foods will heal you an extra half a heart.\n\n  +Sophisticated Palate"
	title="Great Palate"

func onUse():
	GameData.player.increasedFoodHeal = true
