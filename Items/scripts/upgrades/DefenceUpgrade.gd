extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/33_a.webp")
	textureFilePath = "res://assets/33_a.webp"
	description="Increases your defence level, making enemies hit less on you more consistently.\n\n  +Defence"
	title="Thick Skin"

func onUse():
	GameData.player.increaseStat("defence", 2)
