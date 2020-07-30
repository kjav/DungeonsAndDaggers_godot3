extends "UpgradeBase.gd"

func _init():
	._init()
	texture = preload("res://assets/37_a.webp")
	textureFilePath = "res://assets/37_a.webp"
	description="Increases your strength level, this means you'll hit higher more consistently.\n\n  +Strength"
	title="Berserker"

func onUse():
	GameData.player.increaseStat("strength", 2)
