extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/33_a.webp")
	description="Increases your defence level, making enemies less likely to hit you.\n\n  +3 defence"
	title="Thick Skin"

func onUse():
	GameData.player.increaseStat("defence", 3)
