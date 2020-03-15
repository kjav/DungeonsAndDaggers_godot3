extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/16_a.png")
	textureFilePath = "res://assets/16_a.png"
	description="Learn to make the most of potions, brief potions will now last much longer.\n\n  +Extended Brief Potions"
	title="Long Potions"

func onUse():
	GameData.player.extendBriefPotions = true
